
import SwiftUI

struct MainView: View {
    @State private var show = "Показать"
    @State private var item = ViewModel().filterDataNotDone()
    @Environment(\.dismiss) var dismiss
    @State private var showModal = false
    @State private var selectedIndex: Int = 0
    @State private var selectedItem: TodoItem?
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ListItem()
                Button {
                    let newItem = TodoItem(text: "", important: .ordinary)
                    ViewModel().addItem(item: newItem)
                    selectedItem = newItem
                    ViewModel().addItem(item: newItem)
                    showModal = true
                } label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(Color("Blue"))
                            .frame(width: 44, height: 44)
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(Color.white)
                            .frame(width: 22, height: 22)
                            .bold()
                    }
                }
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 8)
            }
        }
    }

    private func ListItem() -> some View {
        List {
            Section {
                ForEach(Array(item.enumerated()), id: \.offset) { index, element
                    in ListRow(item: element).tag(element)
                        .onTapGesture {
                            selectedItem = element
                            selectedIndex = index
                            showModal = true
                        }
                }
                .listRowBackground(Color.backSecondary)
                .swipeActions(edge: .leading) {
                    Button {
//                        доделать
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .tint(.green)
                }
                .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            ViewModel().data.remove(at: selectedIndex)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        Button {
                                            showModal = true
                                        } label: {
                                            Image(systemName: "info.circle")
                                        }
                                        .tint(Color("ColorGrayLight"))
                                    }

            } header: {
                HStack {
                    Text("Выполнено - \(ViewModel().filterDataIsDone().count)")
                        .foregroundStyle(Color.labelTertiary)
                        .font(.system(size: 15))
                    Spacer()
                    Button(action: {
                        if isShow {
                            self.show = "показать"
                            item = ViewModel().filterDataNotDone()
                        } else {
                            self.show = "скрыть"
                            item = ViewModel().data
                        }
                        isShow.toggle()
                    }, label: {
                        Text(self.show)
                            .foregroundStyle(Color.blue)
                            .font(.system(size: 15))
                    })
                }
            }

        } .navigationTitle(
            Text("Мои дела")
                .foregroundStyle(Color.labelPrimary))
        .font(.system(size: 38))
        .background(Color("BackSecondary"))
        .sheet(isPresented: $showModal) {
            ModalView(
                toDo: selectedItem ?? TodoItem(text: "", important: .ordinary), selectItem: selectedItem ?? TodoItem(text: "", important: .ordinary),
                importance: selectedItem?.important ?? .ordinary,
                isDeadline: selectedItem?.deadline != nil ? true : false,
                isShowDatePicker: false,
                text: selectedItem?.text ?? ""
            )
        }
    }
}

#Preview {
    MainView()
}
