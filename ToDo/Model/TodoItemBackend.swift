import Foundation

struct Response: Codable {
    let status: String
    let list: [TodoItem]
    var revision: Int = 0

    mutating func increaseRevision() {
        revision += 1
    }
}
