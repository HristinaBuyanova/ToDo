import SwiftUI

@main
struct ToDoApp: App {

    init() {
        Logger.setupLogger()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
