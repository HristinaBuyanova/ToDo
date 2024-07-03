
import Foundation

// MARK: ToDoItem - JSON
extension TodoItem {
    enum Properties: String, CaseIterable {
        case id = "id"
        case text = "text"
        case important = "important"
        case deadline = "deadline"
        case color = "color"
        case isDone = "isDone"
        case creationDate = "creationDate"
        case modifiedDate = "modifiedDate"
    }

    var json: Any {
        var dictionary: [String: Any] = [
            Properties.id.rawValue: id,
            Properties.text.rawValue: text,
            Properties.isDone.rawValue: isDone,
            Properties.creationDate.rawValue: creationDate.timeIntervalSince1970
        ]

        if important != .ordinary {
            dictionary[Properties.important.rawValue] = important.rawValue
        }

        if let deadline = deadline {
            dictionary[Properties.deadline.rawValue] = deadline.timeIntervalSince1970
        }

        if let modifiedDate = modifiedDate {
            dictionary[Properties.modifiedDate.rawValue] = modifiedDate.timeIntervalSince1970
        }

        if let color = color {
            dictionary[Properties.color.rawValue] = color
        }

        return dictionary
    }

    static func parse(json: Any) -> TodoItem? {
        guard let dictionary = json as? [String: Any],
              let id = dictionary[Properties.id.rawValue] as? String,
              let text = dictionary[Properties.text.rawValue] as? String,
              let creationDateTimeInterval = dictionary[Properties.creationDate.rawValue] as? TimeInterval,
              let isDone = dictionary[Properties.isDone.rawValue] as? Bool
        else { return nil }

        let important: Importance
        if let importantValue = dictionary[Properties.important.rawValue] as? String {
            important = Importance(rawValue: importantValue) ?? .ordinary
        } else {
            important = .ordinary
        }

        let deadline = Date(anyTimeIntervalSince1970: dictionary[Properties.deadline.rawValue])
        let creationDate = Date(anyTimeIntervalSince1970: creationDateTimeInterval) ?? Date()
        let modifiedDate = Date(anyTimeIntervalSince1970: dictionary[Properties.modifiedDate.rawValue])

        return TodoItem(
            id: id,
            text: text,
            important: important,
            deadline: deadline,
            isDone: isDone, 
            color: dictionary[Properties.color.rawValue] as? String,
            creationDate: creationDate,
            modifiedDate: modifiedDate
        )
    }
}
