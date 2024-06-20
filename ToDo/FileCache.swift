import Foundation

class FileCache {

    private var toDoItems: [TodoItem] = []

    func addToDoItems(_ item: TodoItem) {
        if !toDoItems.contains(where: { $0.id == item.id }) {
            toDoItems.append(item)
        }
//        saveData?
    }

    func deleteToDoItems(_ item: TodoItem) {
        if let index = toDoItems.firstIndex(where: { $0 == item}) {
            toDoItems.remove(at: index)
        }
//        saveData?
    }

    func saveTodoListToFile(item: TodoItem) throws {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("todoList.json")

        let todoListData = try JSONSerialization.data(withJSONObject: item.json)
            try todoListData.write(to: fileURL)
        }

    func loadTodoListFromFile() throws {
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("todoList.json") else { throw FileCacheError.one }

        let data = try Data(contentsOf: fileURL)
        let toDoItems = try JSONSerialization.jsonObject(with: data)
//                let toDoItems = try JSONDecoder().decode([TodoItem].self, from: data)
        self.toDoItems = TodoItem.parse(json: toDoItems)
        }

    enum FileCacheError: Error {
        case one
        case two
    }

}
