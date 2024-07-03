
import SwiftUI

struct ImportancePicker: View {
    @Binding var importance: Importance

    var body: some View {
        Picker("", selection: $importance) {
            Image(systemName: "arrow.down")
                .tag(Importance.unimportant)
            Text("нет")
                .tag(Importance.ordinary)
            Text("‼")
                .tag(Importance.important)
        }
        .pickerStyle(.segmented)
    }
}
