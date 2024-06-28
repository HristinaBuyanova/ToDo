
import SwiftUI

struct ModalView: View {
    var toDo: TodoItem
    @State private var selectItem: TodoItem
    @Environment(\.dismiss) var dismiss
    @State var importance: TodoItem.Importance = .ordinary
    @State var isExpires: Bool = false
    @State var selectedDate: Date = Date().addingTimeInterval(24*3600)
    @State var isShowDatePicker: Bool = false
    @State var text: String = ""

    init(toDo: TodoItem) {
        self.toDo = toDo
        self._selectItem = State(initialValue: toDo)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    
                    TextField("Что надо сделать?", text: $text, axis: .vertical)
                        .lineLimit(3...)
                }

                Section {
                    VStack {
                        importanceSection
//                            .animation(nil)
                        Divider()
//                            .animation(nil)
                        expiresSection
                    }
                }

                Section {
                    HStack {
                        Spacer()
                        Button(
                            role: .destructive,
                            action: {
                            },
                            label: {
                                Text("Удалить")
                            })
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Дело")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отменить") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Сохранить") {

                    }
                }
            }
            .onChange(of: isExpires) { value in
                withAnimation(.easeInOut(duration: 1)) {
                    isShowDatePicker = value

                }
            }
        }
        .animation(.easeInOut)
    }

    var importanceSection: some View {
        HStack {
            Text("Важность")
            Spacer()
            ImportancePicker(importance: $importance)
                .frame(width: 140)
        }
    }

    var expiresSection: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Сделать до")
                    if isExpires {
                        showDatePickerButton
                    }
                }
                Spacer()
                Toggle("", isOn: $isExpires)
            }
            .animation(nil)

            if isShowDatePicker {
                Divider()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale.init(identifier: Locale.preferredLanguages.first ?? "en-US"))
                    .transition(
                        .slide
                        //                        .opacity.combined(with: .move(edge: .top))
                    )
                    .animation(.easeInOut)
            }
        }
    }

    var showDatePickerButton: some View {
        Button(
            action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isShowDatePicker.toggle()
                }
            },
            label: {
                let text = selectedDate.string()
                Text(text)
                    .font(.footnote)
                    .fontWeight(.bold)
            }
        )
    }
}

struct ImportancePicker: View {
    @Binding var importance: TodoItem.Importance

    var body: some View {
        Picker("", selection: $importance) {
            Image(systemName: "arrow.down")
                .tag(TodoItem.Importance.unimportant)
            Text("нет")
                .tag(TodoItem.Importance.ordinary)
            Text("‼")
                .tag(TodoItem.Importance.important)
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    MainView()
}
