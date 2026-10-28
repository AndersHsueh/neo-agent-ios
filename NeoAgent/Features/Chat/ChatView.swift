import SwiftUI

/// 单个会话的对话流：消息、流式回答、工具调用与输入框。
/// M3 实现，这里先固定入口签名，避免 Sessions 层之后返工。
struct ChatView: View {
    let session: NeoSession

    var body: some View {
        Text("会话：\(session.name)")
            .navigationTitle(session.name)
    }
}
