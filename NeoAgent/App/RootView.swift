import SwiftUI

/// 根视图：未配对走 Onboarding，配对后进入主界面。
struct RootView: View {
    @Environment(AppEnvironment.self) private var environment

    var body: some View {
        Group {
            if environment.connection == nil {
                OnboardingView()
            } else {
                MainTabView()
            }
        }
        .tint(Theme.accent)
    }
}

/// 主界面：会话列表 + 设置。
/// 导航结构按「App 级」放这里，Feature 之间不直接互相跳转。
private struct MainTabView: View {
    var body: some View {
        TabView {
            SessionsView()
                .tabItem {
                    Label("会话", systemImage: "text.bubble")
                }

            SettingsView()
                .tabItem {
                    Label("设置", systemImage: "gearshape")
                }
        }
    }
}
