
import Foundation

struct Category: StringIdentifiable {

    let id: String
    let text: String
    let color: String?
    let creationDate: Date

    init(id: String = UUID().uuidString, text: String = "", color: String? = nil, creationDate: Date = .now) {
        self.id = id
        self.text = text
        self.color = color
        self.creationDate = creationDate
    }

    enum Keys: String {
        case id, text, color, creationDate
    }

}

extension Category: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.text == rhs.text &&
        lhs.color == rhs.color &&
        lhs.creationDate == rhs.creationDate
    }

}

extension Category: FileCachableJson {

    var json: Any {
        var dict: [String: Any] = [
            Keys.id.rawValue: id,
            Keys.text.rawValue: text,
            Keys.creationDate.rawValue: creationDate.timeIntervalSince1970
        ]

        if let color {
            dict[Keys.color.rawValue] = color
        }

        return dict
    }

    static func parse(json: Any) -> Category? {
        switch json {
        case let jsonString as String: parse(string: jsonString)
        case let jsonData as Data: parse(data: jsonData)
        case let jsonDict as [String: Any]: parse(dict: jsonDict)
        default: nil
        }
    }

    private static func parse(string: String) -> Category? {
        guard let data = string.data(using: .utf8) else { return nil }
        return parse(data: data)
    }

    private static func parse(data: Data) -> Category? {
        guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        return parse(dict: dict)
    }

    private static func parse(dict: [String: Any]) -> Category? {
        guard
           let id = dict[Keys.id.rawValue] as? String,
           let text = dict[Keys.text.rawValue] as? String,
           let color = dict[Keys.color.rawValue] as? String,
           let creationDateTimeInterval = dict[Keys.creationDate.rawValue] as? TimeInterval
        else { return nil }
        let creationDate = Date(timeIntervalSince1970: creationDateTimeInterval)
        return Category(id: id, text: text, color: color, creationDate: creationDate)
    }

}

extension Category: FileCachableCsv {

    var csv: String {
        "\(id),\(text),\(color == nil ? " " : color!),\(String(creationDate.timeIntervalSince1970))"
    }

    static var csvHeader: [String] {
        [Keys.id, Keys.text, Keys.color, Keys.creationDate].map { $0.rawValue}
    }

    static func parse(csv: String) -> Category? {
        let row = csv.split(separator: ",").map { String($0) }

        var dict = [String: String]()
        for (index, value) in row.enumerated() {
            dict[csvHeader[index]] = value
        }

        guard let id = dict[Keys.id.rawValue],
              let text = dict[Keys.text.rawValue],
              let color = dict[Keys.color.rawValue],
              let creationDateString = dict[Keys.creationDate.rawValue],
              let creationDateTimeInterval = TimeInterval(creationDateString)
        else {
            return nil
        }
        let creationDate = Date(timeIntervalSince1970: creationDateTimeInterval)
        return Category(id: id, text: text, color: color, creationDate: creationDate)
    }

}

