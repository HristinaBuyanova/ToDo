//
// import Foundation
// import SwiftUI
//
// enum Importance: String, CaseIterable {
//    case unimportant
//    case ordinary
//    case important 
// }
//
// extension Importance: Comparable {
//    static func < (lhs: Importance, rhs: Importance) -> Bool {
//        switch (lhs, rhs) {
//        case (.unimportant, _) where rhs != .unimportant:
//            return true
//        case (.ordinary, .important):
//            return true
//        default:
//            return false
//        }
//    }
// }
