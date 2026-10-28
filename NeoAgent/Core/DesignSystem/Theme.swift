import SwiftUI

/// Matrix 主题的色板与排版入口。
/// Feature 里不要散落硬编码颜色，统一从这里取，方便后续接 Asset Catalog / 多主题。
enum Theme {
    /// 主色：冰绿（与 neo CLI 的 Matrix 视觉一致）。
    static let accent = Color(red: 0.20, green: 0.90, blue: 0.55)
    static let background = Color(red: 0.04, green: 0.05, blue: 0.04)
    static let surface = Color(red: 0.09, green: 0.11, blue: 0.10)
    static let textPrimary = Color(red: 0.90, green: 0.96, blue: 0.92)
    static let textSecondary = Color(red: 0.55, green: 0.62, blue: 0.58)
}
