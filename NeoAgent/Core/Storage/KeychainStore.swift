import Foundation

/// 连接 token 的唯一落点：Keychain。
/// 禁止写入 UserDefaults、源码、日志或 iCloud 备份（策略见 docs/architecture.md）。
enum KeychainStore {
    private static let service = "com.andershsueh.neo-agent-ios"

    // TODO(M1)：SecItemAdd / SecItemUpdate
    static func saveToken(_ token: String, for profileID: UUID) throws {}

    // TODO(M1)：SecItemCopyMatching
    static func token(for profileID: UUID) throws -> String? {
        nil
    }
}
