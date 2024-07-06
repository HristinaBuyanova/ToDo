
import Foundation

extension TodoItem: FileCachableCsv {

    var csv: String {
        var columns: [String] = []
        columns.append(id)
        columns.append("\"\(text)\"")
        columns.append(important.rawValue)
        columns.append(deadline?.string() ?? " ")
        columns.append("\(isDone)")
        columns.append(creationDate.string())
        columns.append(modifiedDate?.string() ?? " ")
        columns.append(color ?? " ")
        columns.append(categoryId ?? " ")
        return columns.joined(separator: ",")

//        "\(id),\(text),\(important == .medium ? " " : important.rawValue)," +
//        "\(deadline == nil ? " " : String(deadline!.timeIntervalSince1970))," +
//        "\(String(isDone)),\(String(creationDate.timeIntervalSince1970))," +
//        "\(modifiedDate == nil ? " " : String(modifiedDate!.timeIntervalSince1970))," +
//        "\(color == nil ? " " : color!),\(categoryId == nil ? " " : categoryId!)"
    }

//    var first = "\(id),\(text),\(important == .medium ? " " : important.rawValue),"
//    var second = "\(deadline == nil ? " " : String(deadline!.timeIntervalSince1970)),"
//    var tree = "\(String(isDone)),\(String(creationDate.timeIntervalSince1970)),"
//    var four = "\(modifiedDate == nil ? " " : String(modifiedDate!.timeIntervalSince1970)),"
//    var five = "\(color == nil ? " " : color!),\(categoryId == nil ? " " : categoryId!)"
//
//    var csv: String {
//
//    }

    static var csvHeader: [String] {
        [
            Keys.id, Keys.text, Keys.important, Keys.deadline, Keys.isDone,
            Keys.creationDate, Keys.modifiedDate, Keys.color, Keys.categoryId
        ].map { $0.rawValue }
    }

    static func parse(csv: String) -> TodoItem? {
        let row = csv.split(separator: ",").map { String($0) }

        var dict = [String: String]()
        for (index, value) in row.enumerated() {
            dict[csvHeader[index]] = value
        }

        guard let id = dict[Keys.id.rawValue],
              let text = dict[Keys.text.rawValue],
              let isDoneString = dict[Keys.isDone.rawValue],
              let isDone = Bool(isDoneString),
              let creationDateString = dict[Keys.creationDate.rawValue],
              let creationDateTimeInterval = TimeInterval(creationDateString)
        else {
            return nil
        }

        let creationDate = Date(timeIntervalSince1970: creationDateTimeInterval)
        let important = Importance(rawValue: dict[Keys.important.rawValue] ?? "") ?? .ordinary
        let deadline = TimeInterval(dict[Keys.deadline.rawValue] ?? "")
                            .flatMap { Date(timeIntervalSince1970: $0) }
        let modifiedDate = TimeInterval(dict[Keys.modifiedDate.rawValue] ?? "")
                            .flatMap { Date(timeIntervalSince1970: $0) }
        let color = dict[Keys.color.rawValue] == " " ? nil : dict[Keys.color.rawValue]
        let categoryId = dict[Keys.categoryId.rawValue] == " " ? nil : dict[Keys.categoryId.rawValue]

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

