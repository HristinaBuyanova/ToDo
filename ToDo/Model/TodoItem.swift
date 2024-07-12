import Foundation
import SwiftUI

struct TodoItem: StringIdentifiable {

    let id: String
    let text: String
    let important: Importance
    let deadline: Date?
    let isDone: Bool
    let creationDate: Date
    let modifiedDate: Date?
    let color: String?
    let categoryId: String?

    init(
        id: String = UUID().uuidString,
        text: String,
        important: Importance = .ordinary,
        deadline: Date? = nil,
        isDone: Bool = false,
        creationDate: Date = .now,
        modifiedDate: Date? = nil,
        color: String? = nil,
        categoryId: String? = nil
    ) {
        self.id = id
        self.text = text
        self.important = important
        self.deadline = deadline
        self.isDone = isDone
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        self.color = color
        self.categoryId = categoryId
    }

    func copyWith(
        text: String? = nil,
        important: Importance? = nil,
        deadline: Date?,
        isDone: Bool? = nil,
        modifiedDate: Date? = nil,
        color: String? = nil,
        categoryId: String? = nil
    ) -> TodoItem {
        TodoItem(
            id: self.id,
            text: text ?? self.text,
            important: important ?? self.important,
            deadline: deadline,
            isDone: isDone ?? self.isDone,
            creationDate: self.creationDate,
            modifiedDate: modifiedDate ?? self.modifiedDate,
            color: color,
            categoryId: categoryId
        )
    }

    func toggleDone(_ isDone: Bool) -> TodoItem {
        TodoItem(
            id: self.id,
            text: self.text,
            important: self.important,
            deadline: self.deadline,
            isDone: isDone,
            creationDate: self.creationDate,
            modifiedDate: self.modifiedDate,
            color: self.color,
            categoryId: self.categoryId
        )
    }

}

extension TodoItem {

    enum Importance: String, CaseIterable, Identifiable, Comparable {
        private static func minimum(_ lhs: Self, _ rhs: Self) -> Self {
            switch (lhs, rhs) {
            case (.important, _), (_, .important): .important
            case (.ordinary, _), (_, .ordinary): .ordinary
            case (.unimportant, _), (_, .unimportant): .unimportant
            }
        }

        static func < (lhs: Self, rhs: Self) -> Bool {
            (lhs != rhs) && (lhs == Self.minimum(lhs, rhs))
        }

        case important, ordinary, unimportant

        var id: Self { self }

        var symbol: AnyView {
            switch self {
            case .unimportant: AnyView(Image(.down))
            case .ordinary: AnyView(Text("нет"))
            case .important: AnyView(Image(.low))
            }
        }
    }

    enum Keys: String {
        case id, text, important, deadline, color
        case categoryId = "category_id"
        case isDone = "is_done"
        case creationDate = "creation_date"
        case modifiedDate = "modified_date"
    }

}

extension TodoItem: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.text == rhs.text &&
        lhs.important == rhs.important &&
        lhs.deadline == rhs.deadline &&
        lhs.isDone == rhs.isDone &&
        lhs.creationDate == rhs.creationDate &&
        lhs.modifiedDate == rhs.modifiedDate &&
        lhs.categoryId == rhs.categoryId
    }

}

extension TodoItem {

    static var empty: TodoItem {
        TodoItem(
            id: UUID().uuidString,
            text: "",
            important: .ordinary,
            deadline: nil,
            isDone: false,
            creationDate: .now,
            modifiedDate: nil,
            color: nil,
            categoryId: nil
        )
    }
}
