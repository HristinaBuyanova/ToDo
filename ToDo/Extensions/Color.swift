//
//  Color.swift
//  ToDo
//
//  Created by Христина Буянова on 03.07.2024.
//

import Foundation
import SwiftUI

extension Color {
    /// Initializes a color from a hexadecimal string.
    /// - Parameter hex: A hexadecimal color string. Supports the following formats:
    ///   - RGB (12-bit): `#RGB`
    ///   - RGB (24-bit): `#RRGGBB`
    ///   - ARGB (32-bit): `#AARRGGBB`
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let a, r, g, b: UInt64

        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    /// A hexadecimal color string representation of the color.
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
    /// Calculates the luminance of the color.
    /// - Returns: The luminance value of the color as a `CGFloat`.
    ///   Uses the relative luminance formula: 0.2126 * red + 0.7152 * green + 0.0722 * blue.
    func luminance() -> CGFloat {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0, 0]
        let r = components[0]
        let g = components[1]
        let b = components[2]

        // Use the relative luminance formula.
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b

        return luminance
    }

    /// A Boolean value indicating whether the color is dark.
    /// - Returns: `true` if the luminance of the color is less than 0.5; otherwise, `false`.
    var isDark: Bool {
        return luminance() < 0.5
    }

    /// The ideal text color (black or white) based on the luminance of the color.
    /// - Returns: `.white` if the color is dark; otherwise, `.black`.
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
    /// Initializes a color that adapts to the current interface style (light or dark mode).
    /// - Parameters:
    ///   - lightModeColor: The color to use in light mode.
    ///   - darkModeColor: The color to use in dark mode.
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
    /// Initializes a color that adapts to the current interface style (light or dark mode).
    /// - Parameters:
    ///   - lightModeColor: The color to use in light mode.
    ///   - darkModeColor: The color to use in dark mode.
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
