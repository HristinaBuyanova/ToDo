
//import Foundation
//
//class ToDoItemsSorter: ObservableObject {
//    enum SortingOption: String, Identifiable, CaseIterable {
//        var id: String {
//            rawValue
//        }
//        case dateAdded = "По дате добавления"
//        case importance = "По важности"
//    }
//
//    enum SortingOrder: String, Identifiable, CaseIterable {
//        var id: String {
//            rawValue
//        }
//
//        case ascending = "По возрастанию"
//        case descending = "По убыванию"
//    }
//
//    private var fileCache: FileCache<TodoItem>
//    private var toDoItems: [TodoItem]
//
//    @Published var currentToDoItems: [TodoItem] = []
//
//    @Published var areCompletedShown: Bool = true {
//        didSet {
//            updateCurrentToDoItems()
//        }
//    }
//
//    @Published var sortingOption: SortingOption = .dateAdded {
//        didSet {
//            updateCurrentToDoItems()
//        }
//    }
//
//    @Published var sortingOrder: SortingOrder = .ascending {
//        didSet {
//            updateCurrentToDoItems()
//        }
//    }
//
//    var completedCount: Int {
//        toDoItems
//            .filter { $0.isDone }
//            .count
//    }
//
//    init() {
//        To;        fileCache = FileCache()
//        toDoItems = []
//
//        do {
//            try fileCache.load(from: "toDoItems")
//            toDoItems = fileCache.toDoItems
//        } catch {
//            print("Failure while loading toDoItems from the file. It is normal if it is the first launch.")
//        }
//
//        updateCurrentToDoItems()
//    }
//
//    func add(_ toDoItem: TodoItem) {
//        guard !toDoItems.contains(where: { $0.id == toDoItem.id }) else { return }
//
//        toDoItems.append(toDoItem)
//        fileCache.addToDoItems(toDoItem)
//
//        updateCurrentToDoItems()
//        save()
//    }
//
//    func addOrUpdate(_ toDoItem: TodoItem) {
//        if let index = toDoItems.firstIndex(where: { toDoItem.id == $0.id }) {
//            toDoItems[index] = toDoItem
//        } else {
//            toDoItems.append(toDoItem)
//        }
//
//        fileCache.addOrUpdate(toDoItem)
//
//        updateCurrentToDoItems()
//        save()
//    }
//
//    @discardableResult
//    func delete(_ toDoItem: TodoItem) -> TodoItem? {
//        guard let index = toDoItems.firstIndex(where: { $0.id == toDoItem.id }) else { return nil }
//
//        let removedToDoItem = toDoItems.remove(at: index)
//        fileCache.delete(toDoItem.id)
//
//        updateCurrentToDoItems()
//        save()
//
//        return removedToDoItem
//    }
//
//    private func save() {
//        do {
//            try fileCache.save(to: "toDoItems")
//        } catch {
//            print("Error saving toDoItems to the file.")
//        }
//    }
//
//    private func updateCurrentToDoItems() {
//        currentToDoItems = toDoItems
//
//        switch sortingOption {
//        case .importance:
//            currentToDoItems = toDoItems.sorted(by: { lhs, rhs in
//                lhs.important < rhs.important
//            })
//        case .dateAdded:
//            currentToDoItems = toDoItems.sorted(by: { lhs, rhs in
//                lhs.creationDate < rhs.creationDate
//            })
//        }
//
//        if sortingOrder == .descending {
//            currentToDoItems.reverse()
//        }
//
//        if !areCompletedShown {
//            currentToDoItems = currentToDoItems.filter { toDoItem in
//                !toDoItem.isDone
//            }
//        }
//    }
//}
