# neo-agent-ios 路线图

> 最后更新：2026-10-28
> 状态：M0 进行中（目录结构与工程定义已落地，未构建）。

## M0 脚手架（当前）

- [x] 目录分层：App / Features / Core / Resources / Tests
- [x] XcodeGen `project.yml`、scheme、签名与 Bundle ID
- [x] Info.plist：本地网络权限、ATS 本地豁免、Bonjour 占位
- [x] 最小可读骨架（Onboarding / Sessions / Settings 占位视图）
- [ ] 首次 `xcodegen generate` + 模拟器构建通过（下一阶段）
- [ ] CI：`xcodebuild test` 冒烟

## M1 配对与连接

- 手动填 host / port，健康检查握手，展示后端版本与协议版本
- token 输入 → Keychain；连接错误按 HTTP / 超时 / 证书分类提示
- 连接状态机 + 设置页「断开并清除配对」
- 验收：换 Wi-Fi / 断网 / 后端关闭后重连，状态可解释

## M2 会话列表

- 会话列表（名称、状态、最后活动时间），下拉刷新
- 新建 / 重命名 / 归档的入口（具体能力以后端为准）
- 只读缓存 + 离线可看
- 验收：100 个会话滚动不卡；状态变化 1s 内可见（靠事件推送）

## M3 对话流

- 历史分页 + 流式回答增量渲染（Markdown 代码块）
- 输入框：发送 / 停止 / 重试；断线续传不重复不丢句
- 工具调用折叠展示（名称 + 结果摘要，不展开大输出）
- 验收：弱网（Network Link Conditioner）下不出现重复消息

## M4 多会话与提醒

- 会话并行状态可视化；后台任务完成提醒（先本地通知）
- 推送方案决策（APNs 是否引入，见 architecture.md §8）

## M5 体验与可访问性

- Matrix 主题 token 化；Dynamic Type / VoiceOver / Reduce Motion 全过
- 深色模式默认；触控目标 ≥ 44pt
- iPad 分栏评估

## M6 分发

- TestFlight 内测；签名与证书流程固化
- App Store 上架评估（局域网自建后端的产品定位需先想清楚）

## 明确不做（当前阶段）

- 在 iOS 上运行 agent 运行时、shell、文件工具
- 实现 i2i 协议（见 architecture.md §1）
- Android / 跨端复用（若未来要做，另起仓库评估）
