import Foundation

final class FileCache {

    private(set) var toDoItems: [TodoItem] = []

    static var data = [TodoItem(text: "Купить хлеб", important: .important, deadline: Date(), isDone: true), TodoItem(text: "Купить хлеб", important: .ordinary, deadline: Date()), TodoItem(text: "Купить хлеб", important: .important, deadline: Date()), TodoItem(text: "Купить хлеб", important: .important, deadline: Date(), isDone: false), TodoItem(text: "Купить хлеб", important: .important, deadline: Date(), isDone: false)]

    private var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func addToDoItems(_ item: TodoItem) {
        if !toDoItems.contains(where: { $0.id == item.id }) {
            toDoItems.append(item)
        }
    }

    func addOrUpdate(_ item: TodoItem) {
        if let index = toDoItems.firstIndex(where: { item.id == $0.id }) {
            toDoItems[index] = item
        } else {
            toDoItems.append(item)
        }
    }

    @discardableResult
    func delete(_ id: String) -> TodoItem? {
        guard let index = toDoItems.firstIndex(where: { id == $0.id }) else { return nil }
        return toDoItems.remove(at: index)
    }

    enum FileFormat: String {
        case json, csv
    }

    func save(to file: String, format: FileFormat = .json) throws {
        let path = documentsDirectory
            .appending(path: file)
            .appendingPathExtension(format.rawValue)

        switch format {
        case .json:
            try saveToJSON(at: path)
        case .csv:
            try saveToCSV(at: path)
        }
    }

    func load(from file: String, format: FileFormat = .json) throws {
        let path = documentsDirectory
            .appending(path: file)
            .appendingPathExtension(format.rawValue)

        switch format {
        case .json:
            toDoItems = try loadFromJSON(at: path)
        case .csv:
            toDoItems = try loadFromCSV(at: path)
        }
    }
}

    extension FileCache {

        // JSON
        private func saveToJSON(at path: URL) throws {
            let items = toDoItems.map { $0.json }

            let data = try JSONSerialization.data(withJSONObject: items, options: .prettyPrinted)
            try data.write(to: path)
        }

        private func loadFromJSON(at path: URL) throws -> [TodoItem] {
            let data = try Data(contentsOf: path)
            let items = try JSONSerialization.jsonObject(with: data) as! [Any]
            let toDoItems = items.compactMap { TodoItem.parse(json: $0) }

            return toDoItems
        }

        // CSV
        private func saveToCSV(at path: URL) throws {
            let fields = ["id", "text", "important", "deadline", "isDone", "creationDate", "modifiedDate"]
            var data = "\"" + fields.joined(separator: "\",\"") + "\"\n"

            data += toDoItems
                .reduce("", { partialResult, todoItem in
                    return partialResult + todoItem.csv
                })

            try data.write(to: path, atomically: true, encoding: .utf8)
        }

        private func loadFromCSV(at path: URL) throws -> [TodoItem] {
            let data = try String(contentsOf: path)

            let lines = data.components(separatedBy: .newlines).dropFirst()
            let toDoItems: [TodoItem] = lines.compactMap { TodoItem.parse(csv: $0) }

            return toDoItems
        }
    }


