import SwiftUI

struct MainView: View {

    //    @ObservedObject var toDoItemsStore: ToDoItemsSorter

    @StateObject var viewModel = ListViewModel()
    @FocusState private var isFocused

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(viewModel.todoItems) { todoItem in
                        ListRow(
                            todoItem: todoItem,
                            color: viewModel.colorFor(todoItem: todoItem),
                            onTap: {
                                viewModel.selectedTodoItem = todoItem
                                viewModel.todoViewPresented.toggle()
                            },
                            onRadioButtonTap: {
                                viewModel.toggleDone(todoItem)
                            }
                        )
                        .markableAsDone(isDone: todoItem.isDone) {
                            viewModel.toggleDone(todoItem)
                        }
                        .deletable {
                            viewModel.delete(todoItem)
                        }
                        .withInfo {
                            viewModel.selectedTodoItem = todoItem
                            viewModel.todoViewPresented.toggle()
                        }
                    }
                    newEventTextView
                } header: { headerView }
                .listRowBackground(Color.backSecondary)
            }
            .groupedList()
            .navigationTitle("Мои дела")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    calendarButton
                }
            }
            .safeAreaInset(edge: .bottom) {
                floatingButton
            }
            .sheet(isPresented: $viewModel.todoViewPresented) {
                ToDoItemDetail(
                    viewModel: ViewModel(
                        todoItem: viewModel.todoItemToOpen
                    )
                )
            }
            .fullScreenCover(isPresented: $viewModel.calendarViewPresented) {
                CalendarView()
                    .ignoresSafeArea()
            }
        }
    }

    private var newEventTextView: some View {
        TextField(
            "",
            text: $viewModel.newTodo,
            prompt: Text("Новая заметка").foregroundStyle(.labelTertiary)
        )
        .listRowInsets(EdgeInsets(top: 16, leading: 60, bottom: 16, trailing: 16))
        .focused($isFocused)
        .foregroundStyle(.labelPrimary)
        .onSubmit {
            isFocused = false
            if !viewModel.newTodo.isEmpty {
                viewModel.addItem(TodoItem(text: viewModel.newTodo))
                viewModel.newTodo = ""
                isFocused = true
            }
        }
    }

    private var headerView: some View {
        HStack {
            Text("Выполнено - \(viewModel.doneCount)")
                .foregroundStyle(.labelTertiary)
            Spacer()
            menu
        }
        .textCase(.none)
        .padding(.vertical, 6)
        .padding(.horizontal, -10)
    }

    private var menu: some View {
        Menu {
            Section {
                Button {
                    viewModel.toggleShowCompleted()
                } label: {
                    Label(
                        viewModel.showCompleted ? "скрыть" : "показать",
                        systemImage: viewModel.showCompleted ? "eye.slash" : "eye"
                    )
                }
            }
            Section {
                Button {
                    viewModel.toggleSortByPriority()
                } label: {
                    Label(
                        viewModel.sortType.descriptionOfNext,
                        systemImage: "arrow.up.arrow.down"
                    )
                }
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .foregroundStyle(.labelPrimary, .blue)
                .frame(width: 20, height: 20, alignment: .center)
        }
    }
    private var floatingButton: some View {
        Button {
            viewModel.todoViewPresented.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .foregroundStyle(.white, .blue)
                .frame(width: 44, height: 44, alignment: .center)
                .shadow(color: .gray, radius: 5, x: 0, y: 8)
                .padding(.vertical, 10)
        }
    }

    private var calendarButton: some View {
        Button {
            viewModel.calendarViewPresented.toggle()
        } label: {
            Image(systemName: "calendar")
                .resizable()
                .foregroundStyle(.labelPrimary, .blue)
                .frame(width: 20, height: 20, alignment: .center)
        }
    }
}

#Preview {
    MainView()
}
