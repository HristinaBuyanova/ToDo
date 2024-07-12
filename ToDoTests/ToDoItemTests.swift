import XCTest
@testable import ToDo

final class ToDoItemTests: XCTestCase {

func testTodoItemInitialization() {
        let id = "1"
        let text = "Купить хлеб"
    let important = TodoItem.Importance.important
        let deadline = Date()
        let isDone = false
        let creationDate = Date()
        let modifiedDate = Date()

    let todoItem = TodoItem(
        id: id,
        text: text,
        important: important,
        deadline: deadline,
        isDone: isDone,
        creationDate: creationDate,
        modifiedDate: modifiedDate
    )

        XCTAssertEqual(todoItem.id, id)
        XCTAssertEqual(todoItem.text, text)
        XCTAssertEqual(todoItem.important, important)
        XCTAssertEqual(todoItem.deadline, deadline)
        XCTAssertEqual(todoItem.isDone, isDone)
        XCTAssertEqual(todoItem.creationDate, creationDate)
        XCTAssertEqual(todoItem.modifiedDate, modifiedDate)
    }

// func testTodoItemJSONSerialization() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let id = "1"
//        let text = "Купить хлеб"
//        let important = TodoItem.Importance.important
//    let deadline = Date()
//        let isDone = false
//        let creationDate = Date()
//        let modifiedDate = Date()
//
//    let todoItem = TodoItem(
//        id: id,
//        text: text,
//        important: important,
//        deadline: deadline,
//        isDone: isDone,
//        creationDate: creationDate,
//        modifiedDate: modifiedDate
//    )
//
//        let json = todoItem.json
//
//        guard let dict = json as? [String: Any] else {
//            XCTFail("Failed to serialize todoItem to JSON")
//            return
//        }
//
//        XCTAssertEqual(dict["id"] as? String, id)
//        XCTAssertEqual(dict["text"] as? String, text)
//        XCTAssertEqual(dict["important"] as? String, important.rawValue)
//        XCTAssertEqual(dict["isDone"] as? Bool, isDone)
//        XCTAssertEqual(dict["creationDate"] as? String, dateFormatter.string(from: creationDate))
//        XCTAssertEqual(dict["deadline"] as? String, dateFormatter.string(from: deadline))
//        XCTAssertEqual(dict["modifiedDate"] as? String, dateFormatter.string(from: modifiedDate))
//    }

func testTodoItemJSONParsing() {
        let id = "1"
        let text = "Купить хлеб"
        let important = TodoItem.Importance.important
        let deadline = Date(timeIntervalSince1970: 3)
        let isDone = false
        let creationDate = Date(timeIntervalSince1970: 3)
        let modifiedDate = Date(timeIntervalSince1970: 3)

    let todoItem = TodoItem(
        id: id,
        text: text,
        important: important,
        deadline: deadline,
        isDone: isDone,
        creationDate: creationDate,
        modifiedDate: modifiedDate
    )

        let json = todoItem.json

        guard let parsedTodoItem = TodoItem.parse(json: json) else {
            XCTFail("Failed to parse JSON to todoItem")
            return
        }

        XCTAssertEqual(parsedTodoItem.id, id)
        XCTAssertEqual(parsedTodoItem.text, text)
        XCTAssertEqual(parsedTodoItem.important, important)
        XCTAssertEqual(parsedTodoItem.deadline, deadline)
        XCTAssertEqual(parsedTodoItem.isDone, isDone)
        XCTAssertEqual(parsedTodoItem.creationDate, creationDate)
        XCTAssertEqual(parsedTodoItem.modifiedDate, modifiedDate)
    }
}
