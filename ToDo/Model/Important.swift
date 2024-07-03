
import Foundation

enum Importance: String, CaseIterable, Comparable {
    static func < (lhs: Importance, rhs: Importance) -> Bool {
        switch (lhs, rhs) {
        case (.unimportant, _) where rhs != .unimportant:
            return true
        case (.ordinary, .important):
            return true
        default:
            return false
        }
    }
    case unimportant = "неважная"
    case ordinary = "обычная"
    case important = "важная"
}

