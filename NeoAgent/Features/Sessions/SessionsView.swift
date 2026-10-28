import SwiftUI

/// 会话列表：多会话工作台的入口。
struct SessionsView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView {
                Label("尚未连接", systemImage: "text.bubble")
            } description: {
                Text("配对成功后，这里显示 neo 后端上的会话。")
            }
            .navigationTitle("会话")
        }
    }
}
