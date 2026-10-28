import SwiftUI

/// 首次启动：填写后端地址 / 端口，配对后写入 ConnectionProfile 与 Keychain。
/// 目前只是结构占位，输入校验与配对逻辑在 M1 实现（见 docs/roadmap.md）。
struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "server.rack")
                    .font(.system(size: 48))
                    .foregroundStyle(Theme.accent)

                Text("连接 neo 后端")
                    .font(.title2.weight(.semibold))

                Text("在电脑上启动 neo agent 后端后，填入它的地址完成配对。")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(24)
            .navigationTitle("配对")
        }
    }
}
