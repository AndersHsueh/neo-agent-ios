import Foundation
import Observation

/// 组合根：App 启动时构造一次，向下注入依赖。
/// 只持有跨 Feature 共享的对象，不承载业务规则。
@Observable
final class AppEnvironment {
    /// 已保存的连接；nil 表示尚未与后端配对。
    var connection: ConnectionProfile?

    /// 当前 API 客户端；未配对时为 nil。
    private(set) var apiClient: (any NeoAPIClientProtocol)?

    init(connection: ConnectionProfile? = nil) {
        self.connection = connection
        if let connection {
            self.apiClient = NeoAPIClient(profile: connection)
        }
    }
}
