import SwiftUI

/// 设置：连接、外观、关于。分组顺序即信息优先级。
struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section("连接") {
                    LabeledContent("状态", value: "未连接")
                }

                Section("关于") {
                    LabeledContent("版本", value: "0.1.0")
                }
            }
            .navigationTitle("设置")
        }
    }
}
