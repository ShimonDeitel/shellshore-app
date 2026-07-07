import SwiftUI

/// Unique visual identity for Shell Shore: sea-glass teal with sandy gold.
enum Theme {
    static let accent = Color(hex: "#1E7A72")
    static let accentSecondary = Color(hex: "#F2C879")
    static let background = Color(hex: "#F6F2E9")
    static let ink = Color(hex: "#122B29")

    static var titleFont: Font {
        Font.system(.largeTitle, design: .rounded).weight(.bold)
    }

    static var bodyFont: Font {
        Font.system(.body, design: .rounded)
    }

    static var cardCornerRadius: CGFloat { 18 }
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: s).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xFF) / 255.0
        let g = Double((v >> 8) & 0xFF) / 255.0
        let b = Double(v & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
