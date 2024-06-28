

import Foundation

final class ViewModel {

    public var data = [TodoItem(text: "Купить хлеб", important: .important, deadline: Date(), isDone: true), TodoItem(text: "Купить хлеб", important: .ordinary, deadline: Date()), TodoItem(text: "Купить хлеб", important: .important, deadline: Date())]

    func addItem(item: TodoItem) {
        data.append(item)
    }

    func filterDataNotDone () -> [TodoItem] {
        data.filter{ !$0.isDone }
    }

    func filterDataIsDone () -> [TodoItem] {
        data.filter{ $0.isDone }
    }

    func changeData (index: Int) -> [TodoItem] {
        var item = data[index]
        item.isDone.toggle()
        data[index] = item
        return data
    }
}

