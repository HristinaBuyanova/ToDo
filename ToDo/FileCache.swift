import Foundation

final class FileCache {

    private(set) var toDoItems: [TodoItem] = []

    func addToDoItems(_ item: TodoItem) {
        if !toDoItems.contains(where: { $0.id == item.id }) {
            toDoItems.append(item)
        }
    }

    func deleteToDoItems(_ id: String) {
        toDoItems.removeAll { $0.id == id }
    }
    // MARK: func JSON
    func saveJsonTodoItemsToFile(
        fileName: String
    ) throws {
        let jsons = toDoItems.map {
            $0.json
        }
        guard let fileURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(
            fileName
        ) else {
            throw FileCacheError.errorSave
        }

        let todoListData = try JSONSerialization.data(
            withJSONObject: jsons
        )
        try todoListData.write(
            to: fileURL
        )
    }

    func loadJsonTodoItemsFromFile(fileName: String) throws {
        guard let fileURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(
            fileName
        ) else {
            throw FileCacheError.errorLoad
        }

        let data = try Data(contentsOf: fileURL)
        if let items = try JSONSerialization.jsonObject(with: data) as? [Any] {
            toDoItems = items.compactMap { TodoItem.parse(json: $0) }
        }
    }

    // MARK: func CVS
    func saveCvsTodoItemsToFile(fileName: String) throws {
        let cvs = toDoItems.map { $0.csv }
        guard let fileURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(
            fileName
        ) else {
            throw FileCacheError.errorSave
        }

        let todoListData = try JSONSerialization.data(withJSONObject: cvs)
        try todoListData.write(to: fileURL)
    }

    // MARK: Error
    enum FileCacheError: Error {
        case errorSave
        case errorLoad
    }
}
