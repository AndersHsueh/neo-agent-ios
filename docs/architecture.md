# neo-agent-ios 架构

> 最后更新：2026-10-28
> 状态：设计稿。目录与工程已落地，通信契约仍待后端定型。

## 1. 定位与边界

iOS 端是 neo 的**远程客户端**，不是移动版 agent 运行时。

| 能力 | 所在端 | 说明 |
| --- | --- | --- |
| LLM 调用、上下文、工具执行、shell / 文件 | **后端**（电脑 / 服务器） | iOS 无法运行 Bun、shell 与本地文件工具 |
| 会话生命周期、记忆、技能 | **后端** | 与 CLI / 桌面 GUI 共用同一后端 |
| 展示会话列表 / 对话流、发消息、切档、中断 | **iOS** | 只做控制面与阅读面 |
| 连接配置、token | **iOS** | 只存本机，见 §5 |

**不做的事**（一期）：本地跑 agent、离线执行工具、把 iOS 当 worker 接入 i2i 网络。

### 与 i2i 消息协议的关系

`neo` 仓库里的 [i2i message protocol](../../neo/docs/i2i-message-protocol.md) 解决的是**进程间会话编排**（Dispatcher / Worker）。iOS 端最多扮演 **User / 控制端**，不是 Dispatcher 也不是 Worker，因此**不实现 i2i 信封**，只消费后端暴露的会话 API。若未来要让手机端给 worker 派活，走的是「后端 API 触发 i2i」，而不是把协议搬进 App。

## 2. 分层

```
App（组合根 / 导航）
  └─ Features（Onboarding / Sessions / Chat / Settings）
       └─ Core（Networking / Models / Storage / DesignSystem）
```

依赖方向**只能向下**：

- `App` 允许 import 全部层；负责构造 `AppEnvironment`、决定根视图。
- `Features` 只依赖 `Core`；Feature 之间不互相 import，跨 Feature 跳转由 `App` 层导航负责。
- `Core` 不 import SwiftUI（`DesignSystem` 例外）、不 import 任何 Feature。
- 网络、Keychain 等副作用都藏在协议后面，Feature 依赖协议而非具体实现，便于测试替身。

当前占位：

- `AppEnvironment` 持有 `connection` 与 `apiClient`，未配对时 `apiClient == nil`。
- `NeoAPIClientProtocol` 只定义了 `fetchSessions()`，实现故意抛 `notImplemented`。

## 3. 通信契约（待定）

**现状**：neo 本体目前是 CLI / TUI，没有对外 HTTP 服务；桌面 GUI 的后端仍在规划。因此下面的接口**只是客户端的占位假设**，等后端契约定型后重写本节与 `NeoAPIClient`。

计划能力与候选接口：

| 能力 | 候选接口 | 备注 |
| --- | --- | --- |
| 健康检查 / 版本握手 | `GET /api/health` | 配对第一步；返回协议版本 |
| 会话列表 | `GET /api/sessions` | 含状态：idle / running / waiting_for_user / failed |
| 会话详情与历史 | `GET /api/sessions/{id}` | 分页拉历史 |
| 发消息 | `POST /api/sessions/{id}/messages` | 幂等键必带 |
| 流式事件（回答增量、工具调用、状态） | `GET /api/sessions/{id}/events`（SSE）或 `WS /api/ws` | 选型见「待定项」 |
| 中断 / 切档 | `POST /api/sessions/{id}/interrupt`、`/tier` | 与 CLI 命令语义对齐 |

约束：

- **协议版本**随握手返回并校验，不匹配时 UI 明确提示，不静默降级。
- 事件必须带**单调递增游标**，断线重连按游标续传，避免丢半句话。
- 所有改变状态的请求带幂等键（与 i2i `id` 去重同思路）。

## 4. 连接与配对

1. 用户在电脑上启动 neo 后端（未来由 neo / neo-agent-app 提供）。
2. iOS 端二选一：
   - **手动**：填 host / port（一期主路径）；
   - **发现**：Bonjour `_neo._tcp`（`Info.plist` 已声明 `NSBonjourServices` 与 `NSLocalNetworkUsageDescription`）。
3. 握手成功后展示 token 输入 / 扫码（方式待定），token 写 Keychain。
4. `ConnectionProfile` 只存 host / port / usesTLS，不含密钥。

ATS：只在 `NSAppTransportSecurity.NSAllowsLocalNetworking = true` 放行**局域网明文**；跨公网必须 HTTPS。

## 5. 本地状态与离线

- 会话列表与最近消息**只读缓存**，断网时可看，不可发；发送按钮在离线时禁用并说明原因。
- 连接状态是一等公民：`.disconnected / .connecting / .connected / .reconnecting`，UI 顶部常驻可见。
- 缓存介质先定文件 / SwiftData 其一，M2 再落定；不把 token 或完整工具输出写缓存。

## 6. 安全

- token 只进 Keychain（`KeychainStore`），禁止 UserDefaults / 源码 / 日志 / 分享。
- 日志与导出对 host 做脱敏（保留末段），不发完整连接信息。
- 不在 App 内保存 shell 命令的敏感参数。
- 后端地址可被用户随时清除（设置页「断开并清除配对」）。

## 7. 目录职责

| 目录 | 职责 | 不该出现 |
| --- | --- | --- |
| `App/` | 组合根、根视图、Tab 结构 | 业务规则、网络请求 |
| `Features/<Name>/` | 单个功能的 View / 局部状态 | 跨 Feature import、直接 `URLSession` |
| `Core/Networking/` | API 客户端、事件流、错误映射 | SwiftUI |
| `Core/Models/` | 纯数据模型（Codable / Sendable） | 网络与持久化细节 |
| `Core/Storage/` | Keychain、本地缓存 | UI |
| `Core/DesignSystem/` | 颜色、字体、通用组件 | 具体业务 |

## 8. 待定项

- [ ] 后端由谁提供、以什么形态提供（neo 内建 server / neo-agent-app 的 Bun 后端 / 独立 broker）
- [ ] 流式传输选型：SSE vs WebSocket vs HTTP 分块（取决于后端生态）
- [ ] 鉴权：一次性配对码 / 长期 token / 双端证书
- [ ] 一个后端被多台手机同时连接时，会话占用与冲突规则
- [ ] 后台执行与推送：iOS 后台 WebSocket 不可靠，是否引入 APNs
- [ ] 多设备同步：桌面 GUI 与 iOS 是否共享已读、任务台账
- [ ] iPad / 横屏适配与分栏（一期只做 iPhone 竖屏）
