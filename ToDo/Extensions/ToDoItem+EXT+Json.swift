
import Foundation

// MARK: - Parse JSON
extension TodoItem: FileCachableJson {

    var json: Any {
        var dict: [String: Any] = [
            Keys.id.rawValue: id,
            Keys.text.rawValue: text,
            Keys.creationDate.rawValue: creationDate.timeIntervalSince1970,
            Keys.isDone.rawValue: isDone
        ]

        if important != .ordinary {
            dict[Keys.important.rawValue] = important.rawValue
        }

        if let deadline {
            dict[Keys.deadline.rawValue] = deadline.timeIntervalSince1970
        }

        if let color {
            dict[Keys.color.rawValue] = color
        }

        if let categoryId {
            dict[Keys.categoryId.rawValue] = categoryId
        }

        if let modifiedDate {
            dict[Keys.modifiedDate.rawValue] = modifiedDate.timeIntervalSince1970
        }

        return dict
    }

    static func parse(json: Any) -> TodoItem? {
        switch json {
        case let jsonString as String: parse(string: jsonString)
        case let jsonData as Data: parse(data: jsonData)
        case let jsonDict as [String: Any]: parse(dict: jsonDict)
        default: nil
        }
    }

    private static func parse(string: String) -> TodoItem? {
        guard let data = string.data(using: .utf8) else { return nil }
        return parse(data: data)
    }

    private static func parse(data: Data) -> TodoItem? {
        guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        return parse(dict: dict)
    }

    private static func parse(dict: [String: Any]) -> TodoItem? {
        guard
           let id = dict[Keys.id.rawValue] as? String,
           let text = dict[Keys.text.rawValue] as? String,
           let creationDateTimeInterval = dict[Keys.creationDate.rawValue] as? TimeInterval,
           let isDone = dict[Keys.isDone.rawValue] as? Bool
        else { return nil }

        let creationDate = Date(timeIntervalSince1970: creationDateTimeInterval)

        let importantString = dict[Keys.important.rawValue] as? String ?? ""
        let important = Importance(rawValue: importantString) ?? .ordinary

        let deadlineTimeInterval = dict[Keys.deadline.rawValue] as? TimeInterval
        let deadline = deadlineTimeInterval.flatMap { Date(timeIntervalSince1970: $0) }

        let modifiedDateTimeInterval = dict[Keys.modifiedDate.rawValue] as? TimeInterval
        let modifiedDate = modifiedDateTimeInterval.flatMap { Date(timeIntervalSince1970: $0) }

        let color = dict[Keys.color.rawValue] as? String
        let categoryId = dict[Keys.categoryId.rawValue] as? String

        return TodoItem(
           id: id,
           text: text,
           important: important,
           deadline: deadline,
           isDone: isDone,
           creationDate: creationDate,
           modifiedDate: modifiedDate,
           color: color,
           categoryId: categoryId
        )
    }

}


//import Foundation
//
//// MARK: ToDoItem - JSON
//extension TodoItem {
//    enum Properties: String, CaseIterable {
//        case id = "id"
//        case text = "text"
//        case important = "important"
//        case deadline = "deadline"
//        case color = "color"
//        case isDone = "isDone"
//        case creationDate = "creationDate"
//        case modifiedDate = "modifiedDate"
//    }
//
//    var json: Any {
//        var dictionary: [String: Any] = [
//            Properties.id.rawValue: id,
//            Properties.text.rawValue: text,
//            Properties.isDone.rawValue: isDone,
//            Properties.creationDate.rawValue: creationDate.timeIntervalSince1970
//        ]
//
//        if important != .ordinary {
//            dictionary[Properties.important.rawValue] = important.rawValue
//        }
//
//        if let deadline = deadline {
//            dictionary[Properties.deadline.rawValue] = deadline.timeIntervalSince1970
//        }
//
//        if let modifiedDate = modifiedDate {
//            dictionary[Properties.modifiedDate.rawValue] = modifiedDate.timeIntervalSince1970
//        }
//
//        if let color = color {
//            dictionary[Properties.color.rawValue] = color
//        }
//
//        return dictionary
//    }
//
//    static func parse(json: Any) -> TodoItem? {
//        guard let dictionary = json as? [String: Any],
//              let id = dictionary[Properties.id.rawValue] as? String,
//              let text = dictionary[Properties.text.rawValue] as? String,
//              let creationDateTimeInterval = dictionary[Properties.creationDate.rawValue] as? TimeInterval,
//              let isDone = dictionary[Properties.isDone.rawValue] as? Bool
//        else { return nil }
//
//        let important: Importance
//        if let importantValue = dictionary[Properties.important.rawValue] as? String {
//            important = Importance(rawValue: importantValue) ?? .ordinary
//        } else {
//            important = .ordinary
//        }
//
//        let deadline = Date(anyTimeIntervalSince1970: dictionary[Properties.deadline.rawValue])
//        let creationDate = Date(anyTimeIntervalSince1970: creationDateTimeInterval) ?? Date()
//        let modifiedDate = Date(anyTimeIntervalSince1970: dictionary[Properties.modifiedDate.rawValue])
//
//        return TodoItem(
//            id: id,
//            text: text,
//            important: important,
//            deadline: deadline,
//            isDone: isDone, 
//            color: dictionary[Properties.color.rawValue] as? String,
//            creationDate: creationDate,
//            modifiedDate: modifiedDate
//        )
//    }
//}
