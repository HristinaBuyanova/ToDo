
import Foundation

extension TodoItem {
    var csv: String {
        guard
            let json = json as? [String: Any],
            let lastField = Properties.allCases.last else { return "" }
        var csv = ""

        Properties.allCases.forEach { field in
            let value = "\"\(json[field.rawValue] ?? "")\""
            let separator = field != lastField ? "," : "\n"
            csv += value + separator
        }

        return csv
    }

    static func parse(csv: String) -> TodoItem? {
        let values = csv
            .components(separatedBy: "\",\"")

        guard values.count == 8 else { return nil }

        let id = "\(values[0].dropFirst())"
        let text = values[1]
        let important = Importance(rawValue: values[2]) ?? .ordinary
        let deadline = Date(anyTimeIntervalSince1970: values[3])
        let color = values[4]
        let isDone = Bool(values[5]) ?? false
        let creationDate = Date(anyTimeIntervalSince1970: values[6]) ?? Date()
        let modifiedDate = Date(anyTimeIntervalSince1970: "\(values[7].dropLast())")

        return TodoItem(
            id: id,
            text: text,
            important: important,
            deadline: deadline,
            isDone: isDone,
            color: color,
            creationDate: creationDate,
            modifiedDate: modifiedDate
        )
    }

}
