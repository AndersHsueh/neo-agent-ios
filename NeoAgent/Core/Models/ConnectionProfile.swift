import Foundation

/// 如何连到运行在电脑 / 服务器上的 neo 后端。
///
/// 认证 token 不放在这里，只进 Keychain（见 `Core/Storage/KeychainStore.swift`）。
struct ConnectionProfile: Identifiable, Codable, Hashable, Sendable {
    var id: UUID = UUID()
    /// IP 或主机名，如 `192.168.1.10`。
    var host: String
    var port: Int
    var usesTLS: Bool = false

    /// REST 基地址。host/port 应经配对流程校验，非法值属于编程错误。
    var baseURL: URL {
        var components = URLComponents()
        components.scheme = usesTLS ? "https" : "http"
        components.host = host
        components.port = port
        guard let url = components.url else {
            preconditionFailure("ConnectionProfile 含非法 host/port：\(host):\(port)")
        }
        return url
    }
}
