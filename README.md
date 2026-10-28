# neo-agent-ios

neo 的 iOS 客户端 —— 远程连接 neo agent 的移动工作台。

- 形态：**SwiftUI 原生**（iOS 18+），App 内**不含 agent 运行时**
- 定位：电脑 / 服务器上的 neo 后端负责 LLM、工具与会话；iOS 端只做「看状态、读回答、下指令」
- 工程：**XcodeGen**（`project.yml` 是唯一真源，`.xcodeproj` 由它生成、不入库）

## 状态

**仓库初始化阶段：目录结构与工程定义已就位，业务代码未开始，尚未做构建验证。**

## 目录结构

```
neo-agent-ios/
├── project.yml                     # XcodeGen 工程定义（target / scheme / 签名）
├── docs/
│   ├── architecture.md             # 分层、通信契约假设、安全与待定项
│   └── roadmap.md                  # M0–M6 里程碑
├── NeoAgent/                       # App target 源码根
│   ├── App/                        # 组合根与 App 级导航
│   │   ├── NeoAgentApp.swift       # @main
│   │   ├── AppEnvironment.swift    # 依赖容器（连接 / API 客户端）
│   │   └── RootView.swift          # 未配对 → Onboarding；已配对 → 双 Tab
│   ├── Features/                   # 按用户可见功能切分
│   │   ├── Onboarding/             # 配对后端
│   │   ├── Sessions/               # 会话列表
│   │   ├── Chat/                   # 对话流（M3）
│   │   └── Settings/               # 连接 / 关于
│   ├── Core/                       # 与 UI 无关的基础设施
│   │   ├── Networking/             # 后端客户端（REST / WS）
│   │   ├── Models/                 # 连接配置、会话等模型
│   │   ├── Storage/                # Keychain 等敏感凭据落点
│   │   └── DesignSystem/           # Matrix 主题色板
│   └── Resources/
│       ├── Info.plist              # 本地网络权限、ATS 本地豁免、Bonjour
│       └── Assets.xcassets/        # AppIcon / AccentColor
├── NeoAgentTests/                  # 单元测试
└── NeoAgentUITests/                # UI 冒烟测试
```

## 开发前置

- Xcode 26.5
- iOS 18.0+ 模拟器或真机
- [XcodeGen](https://github.com/yonaskolb/XcodeGen)：`brew install xcodegen`
- Apple 开发团队：`BP6XLRFH4K`（写在 `project.yml`，换团队改那一处即可）

## 常用命令

```bash
# 生成 Xcode 工程（首次、以及每次改 project.yml 后）
xcodegen generate

# 构建（模拟器，不指定机型）
xcodebuild -project NeoAgent.xcodeproj -scheme NeoAgent \
  -destination 'generic/platform=iOS Simulator' build

# 跑测试
xcodebuild test -project NeoAgent.xcodeproj -scheme NeoAgent \
  -destination 'generic/platform=iOS Simulator'

# 打开工程
open NeoAgent.xcodeproj
```

## 签名

- Team：Anders Hsueh（`BP6XLRFH4K`）
- Bundle ID：`com.andershsueh.neo-agent-ios`
- 签名方式：Automatic
- 证书不同的人本地覆盖：新建 `LocalSigning.xcconfig`（已 ignore），改 `DEVELOPMENT_TEAM` / Bundle ID

## 文档

- [docs/architecture.md](docs/architecture.md) —— 客户端架构、与后端的契约假设、安全策略、待定项
- [docs/roadmap.md](docs/roadmap.md) —— M0–M6 里程碑

## 相关仓库

- [neo](https://gitee.com/andershsueh/neo-agent) —— CLI / TUI 本体（Bun + TypeScript）
- [neo-agent-app](https://gitee.com/andershsueh/neo-agent-app) —— 桌面 GUI 工作台（Tauri 壳 + Bun 多进程后端）
- 本仓库远端：https://gitee.com/andershsueh/neo-agent-ios
