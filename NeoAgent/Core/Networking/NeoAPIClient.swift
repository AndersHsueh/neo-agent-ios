import Foundation

/// App ↔ neo 后端的接口边界。
///
/// 后端 HTTP/WS 契约尚未定型（见 docs/architecture.md），这里只固定最小读取能力。
/// Feature 层只依赖本协议，便于先做 UI 与测试替身。
protocol NeoAPIClientProtocol: Sendable {
    func fetchSessions() async throws -> [NeoSession]
}

enum NeoAPIError: Error {
    /// 后端尚未提供该能力。
    case notImplemented
    /// 未配对或连接配置不完整。
    case notConfigured
}

struct NeoAPIClient: NeoAPIClientProtocol {
    let profile: ConnectionProfile

    func fetchSessions() async throws -> [NeoSession] {
        throw NeoAPIError.notImplemented
    }
}
