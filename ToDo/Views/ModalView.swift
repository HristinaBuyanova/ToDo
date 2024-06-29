
import SwiftUI

struct ModalView: View {
    var toDo: TodoItem
    @State var selectItem: TodoItem
    @Environment(\.dismiss) var dismiss
    @State var importance: TodoItem.Importance = .ordinary
    @State var isDeadline: Bool = false
    @State var selectedDate: Date = Date().addingTimeInterval(24*3600)
    @State var isShowDatePicker: Bool = false
    @State var text: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Что надо сделать?", text: $text, axis: .vertical)
                        .lineLimit(3...)
                }
                Section {
                    VStack {
                        ImportanceSection()
                        Divider()
                        ExpiresSection()
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
            .onChange(of: isDeadline) { value in
                withAnimation(.easeInOut(duration: 1)) {
                    isShowDatePicker = value
                }
            }
        }
        .animation(.easeInOut)
    }

    private func ImportanceSection() -> some View {
        HStack {
            Text("Важность")
            Spacer()
            ImportancePicker(importance: $importance)
                .frame(width: 140)
        }
    }

    private func ExpiresSection() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Сделать до")
                    if isDeadline {
                        ShowDatePickerButton()
                    }
                }
                Spacer()
                Toggle("", isOn: $isDeadline)
            }
            .animation(nil)
            if isShowDatePicker {
                Divider()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale.init(identifier: Locale.preferredLanguages.first ?? "en-US"))
                    .transition(
                        .slide
                    )
                    .animation(.easeInOut)
            }
        }
    }

    private func ShowDatePickerButton() -> some View {
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

#Preview {
    MainView()
}
