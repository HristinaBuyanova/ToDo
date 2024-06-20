import Foundation

struct TodoItem: Equatable {
    let id: String
    let text: String
    let important: Importance
    let deadline: Date?
    let isDone: Bool
    let creationDate: Date
    let modifiedDate: Date?

    enum Importance: String {
        case unimportant = "неважная"
        case ordinary = "обычная"
        case important = "важная"
    }

    init(id: String = UUID().uuidString,
        text: String,
        important: Importance,
        deadline: Date? = nil,
        isDone: Bool = false,
        creationDate: Date = Date(),
         modifiedDate: Date? = nil
    )
    {
        self.id = id
        self.text = text
        self.important = important
        self.deadline = deadline
        self.isDone = isDone
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
    }
}

extension TodoItem {
    var json: Any {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        var dict: [String: Any] = [
            "id": id,
            "text": text,
            "isDone": isDone,
            "creationDate": dateFormatter.string(from: creationDate)
        ]

        if let deadline = self.deadline {
            dict["deadline"] = dateFormatter.string(from: deadline)
        }

        if important != .ordinary {
            dict["important"] = self.important.rawValue
        }

        if let modifiedDate = self.modifiedDate {
            dict["modifiedDate"] = dateFormatter.string(from: modifiedDate)
        }

        return dict
    }

    static func parse(json: Any) -> TodoItem? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let dict = json as? [String: Any] else { return nil }

        guard let id = dict["id"] as? String,
              let text = dict["text"] as? String,
              let isDone = dict["isDone"] as? Bool,
              let creationDateString = dict["creationDate"] as? String,
              let creationDate = dateFormatter.date(from: creationDateString) else {
            return nil
        }

        var deadline: Date?
            if let deadlineString = dict["deadline"] as? String {
                deadline = dateFormatter.date(from: deadlineString)
            }


        var important: Importance
        if let importantValue = dict["important"] as? String {
            important = TodoItem.Importance(rawValue: importantValue) ?? Importance.ordinary

        var modifiedDate: Date?
            if let modifiedDateString = dict["modifiedDate"] as? String {
                modifiedDate = dateFormatter.date(from: modifiedDateString)
            }


            return TodoItem(
                id: id,
                text: text,
                important: important,
                deadline: deadline,
                isDone: isDone,
                creationDate: creationDate,
                modifiedDate: modifiedDate
            )
        }

    func loadCVS(from cvs: String) -> TodoItem? {
        let components = cvs.components(separatedBy: ",")
        guard components.count >= 4 else { return nil }

        let id = components[0]
        let text = components[1]
        if let important = Importance(rawValue: components[2]) {
            let important = Importance(rawValue: components[2])
        } else {
            let important = Importance.ordinary
        }

        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let deadlineString = components[3]
            let deadline = dateFormatter.date(from: deadlineString)


            let isDone = if components[4] == "true" {
                true
            } else {
                false
            }

        var toDoItem = TodoItem(id: id, text: text, important: important, deadline: deadline, isDone: isDone)
        toDoItem.creationDate = dateFormatter.date(from: components[5]) ?? Date()

        return toDoItem
    }

}

