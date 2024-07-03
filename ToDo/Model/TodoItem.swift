import Foundation

struct TodoItem: Identifiable, Hashable {

    let id: String
    let text: String
    let important: Importance
    let deadline: Date?
    var isDone: Bool
    let color: String?
    let creationDate: Date
    let modifiedDate: Date?

    init(id: String = UUID().uuidString,
        text: String,
        important: Importance,
        deadline: Date? = nil,
        isDone: Bool = false,
        color: String? = nil,
        creationDate: Date = Date(),
        modifiedDate: Date? = nil
    )
    {
        self.id = id
        self.text = text
        self.important = important
        self.deadline = deadline
        self.isDone = isDone
        self.color = color
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
    }
}


