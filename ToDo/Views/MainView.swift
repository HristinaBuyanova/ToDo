
import SwiftUI

struct MainView: View {
    @State private var item = data
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach($item) {
                    $i in ListRow(item: i).tag(i)
//                        .contentShape(Rectangle())
                        .onTapGesture {
                        i.isDone
                            .toggle()
                    }
                } 
            }
        }
    }
}

#Preview {
    MainView()
}
