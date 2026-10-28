import SwiftUI

@main
struct NeoAgentApp: App {
    /// 组合根：整个 App 生命周期内唯一实例。
    @State private var environment = AppEnvironment()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(environment)
                .preferredColorScheme(.dark)
        }
    }
}
