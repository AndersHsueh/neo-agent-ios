import Foundation

/// 后端会话摘要。字段只覆盖客户端最小需求，后端契约定型后按需扩展。
struct NeoSession: Identifiable, Codable, Hashable, Sendable {
    enum Status: String, Codable, Sendable {
        case idle
        case running
        case waitingForUser = "waiting_for_user"
        case failed
    }

    let id: String
    var name: String
    var status: Status
    var updatedAt: Date
}
