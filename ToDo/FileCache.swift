import Foundation

final class FileCache {

    private(set) var toDoItems: [TodoItem] = []

    func addToDoItems(_ item: TodoItem) {
        if !toDoItems.contains(where: { $0.id == item.id }) {
            toDoItems.append(item)
        }
    }

    func deleteToDoItems(_ item: TodoItem) {
        if let index = toDoItems.firstIndex(where: { $0 == item}) {
            toDoItems.remove(at: index)
        }
    }

    func saveTodoItemsToFile(item: TodoItem) throws {
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("todoList.json") else { throw FileCacheError.errorSave }

        let todoListData = try JSONSerialization.data(withJSONObject: item.json)
            try todoListData.write(to: fileURL)
        }

    func loadTodoItemsFromFile() throws -> TodoItem? {
        guard let fileURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(
            "todoList.json"
        ) else {
            throw FileCacheError.errorLoad
        }

        let data = try Data(contentsOf: fileURL)
        let toDoItems = try JSONSerialization.jsonObject(with: data)
        return TodoItem.parse(json: toDoItems)
        }

    enum FileCacheError: Error {
        case errorSave
        case errorLoad
    }
}
