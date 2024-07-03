

import SwiftUI

struct ContentView: View {
    @State private var toDoItemsStore = ToDoItemsStore()
    var body: some View {
        MainView(toDoItemsStore: toDoItemsStore)
    }
}

#Preview {
    ContentView()
}
