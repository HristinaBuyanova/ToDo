import Foundation
import SwiftUI

extension Color {

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let aaa, r, g, b: UInt64

        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        switch hex.count {
        case 3: // RGB (12-bit)
            (aaa, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (aaa, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (aaa, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (aaa, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(aaa) / 255
        )
    }

    var hex: String {
        let components = UIColor(self).cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )

        return hexString
    }
}

extension Color {

    func luminance() -> CGFloat {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0, 0]
        let r = components[0]
        let g = components[1]
        let b = components[2]

        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b

        return luminance
    }

    var isDark: Bool {
        return luminance() < 0.5
    }

    var idealTextColor: Color {
        return isDark ? .white : .black
    }
}

struct AppColors {
    static var separator: Color {
        Color(
            light: Color(red: 0, green: 0, blue: 0, opacity: 0.2),
            dark: Color(red: 1, green: 1, blue: 0.2, opacity: 0.32)
        )
    }

    static var overlay: Color {
        Color(
            light: Color(red: 0, green: 0, blue: 0, opacity: 0.06),
            dark: Color(red: 1, green: 1, blue: 0.2, opacity: 0.32)
        )
    }

    static var navBarBlur: Color {
        Color(
            light: Color(red: 0.98, green: 0.98, blue: 0.98, opacity: 0.8),
            dark: Color(red: 1, green: 1, blue: 0.2, opacity: 0.32)
        )
    }

    static var primary: Color {
        Color(
            light: Color(red: 0, green: 0, blue: 0, opacity: 1),
            dark: Color(red: 1, green: 1, blue: 0.2, opacity: 0.32)
        )
    }

    static var secondary: Color {
        Color(
            light: Color(red: 0, green: 0, blue: 0, opacity: 0.6),
            dark: Color(red: 1, green: 1, blue: 0.2, opacity: 0.32)
        )
    }

    static var tertiary: Color {
        Color(
            light: Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 0.5),
            dark: Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 0.5)
        )
    }

    static var disable: Color {
        Color(
            light: Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 0.15),
            dark: Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 0.15)
        )
    }

    static var red: Color {
        Color(
            light: Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0),
            dark: Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)
        )
    }

    static var green: Color {
        Color(
            light: Color(red: 0.0, green: 1.0, blue: 0.0, opacity: 1.0),
            dark: Color(red: 0.0, green: 1.0, blue: 0.0, opacity: 1.0)
        )
    }

    static var blue: Color {
        Color(
            light: Color(red: 0.0, green: 0.0, blue: 1.0, opacity: 1.0),
            dark: Color(red: 0.0, green: 0.0, blue: 1.0, opacity: 1.0)
        )
    }

    static var gray: Color {
        Color(
            light: Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0),
            dark: Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0)
        )
    }

    static var grayLight: Color {
        Color(
            light: Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0),
            dark: Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1.0)
        )
    }

    static var white: Color {
        Color(
            light: Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0),
            dark: Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0)
        )
    }

    static var iOSPrimary: Color {
        Color(
            light: Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0),
            dark: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1.0)
        )
    }

    static var backPrimary: Color {
        Color(
            light: Color(red: 0.97, green: 0.97, blue: 0.95, opacity: 1.0),
            dark: Color(red: 0.09, green: 0.09, blue: 0.09, opacity: 1.0)
        )
    }

    static var backSecondary: Color {
        Color(
            light: Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0),
            dark: Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0)
        )
    }

    static var elevated: Color {
        Color(
            light: Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0),
            dark: Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1.0)
        )
    }
}

extension Color {

    init(
        light lightModeColor: @escaping @autoclosure () -> Color,
        dark darkModeColor: @escaping @autoclosure () -> Color
    ) {
        self.init(uiColor: UIColor(
            light: UIColor(lightModeColor()),
            dark: UIColor(darkModeColor())
        ))
    }
}

extension UIColor {

    convenience init(
        light lightModeColor: @escaping @autoclosure () -> UIColor,
        dark darkModeColor: @escaping @autoclosure () -> UIColor
    ) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return lightModeColor()
            case .dark:
                return darkModeColor()
            default:
                return lightModeColor()
            }
        }
    }
}

extension UIColor {

    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

}
