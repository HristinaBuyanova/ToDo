
import SwiftUI

struct ToDoItemDetail: View {


    @StateObject var viewModel: ViewModel
    @FocusState private var isFocused
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List {
                Group {
                    Section {
                        newEventTextView
                    }
                    Section {
                        priorityCell
//                        categoryCell
                        deadlineCell
                        if viewModel.isDeadlineEnabled {
                            datePickerCell
                        }
                    }
                    Section {
                        deleteButtonCell
                    }
                }
                .listRowBackground(Color.backgroundSecondary)
                .listRowSeparatorTint(.primarySeparator)
            }
            .groupedList()
            .listSectionSpacing(16)
            .navigationTitle("task")
            .navigationBarTitleDisplayMode(.inline)
            .confirmationDialog("", isPresented: $viewModel.isAlertShown) {
                confirmation
            }
            .sheet(isPresented: $viewModel.isCategoryViewShown) {
                CategoryView(category: $viewModel.category)
                    .toolbar(.hidden, for: .navigationBar)
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismissIfNeeded()
                    } label: {
                        Text("cancel")
                            .font(.todoBody)
                            .foregroundStyle(.primaryBlue)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveItem()
                        dismiss()
                    } label: {
                        Text("save")
                            .font(.todoBody)
                            .foregroundStyle(viewModel.canItemBeSaved ? .primaryBlue : .textTertiary)
                            .bold()
                    }
                    .disabled(!viewModel.canItemBeSaved)
                }
            }
        }
        .interactiveDismissDisabled(viewModel.canItemBeSaved)
    }

    private func dismissIfNeeded() {
        if viewModel.canItemBeSaved {
            viewModel.isAlertShown = true
        } else {
            dismiss()
        }
    }

    private var newEventTextView: some View {
        TextField(
            "",
            text: $viewModel.text,
            prompt: Text("task.placeholder").foregroundStyle(.labelTertiary),
            axis: .vertical
        )
        .frame(minHeight: 120, alignment: .topLeading)
        .focused($isFocused)
        .foregroundStyle(.labelPrimary)
        .overlay(
            HStack {
                if let color = viewModel.color {
                    Spacer()
                    Rectangle()
                        .fill(color)
                        .frame(width: 5)
                        .padding(.trailing, -5)
                        .padding(.vertical, -12)
                }
            }
        )
    }
    private var priorityCell: some View {
        HStack {
            Text("priority")
                .foregroundStyle(.labelPrimary)
                .truncationMode(.tail)
            Spacer()
            Picker("", selection: $viewModel.important) {
                ForEach(TodoItem.Importance.allCases) { $0.symbol }
            }
            .frame(maxWidth: 150)
            .pickerStyle(.segmented)
            .backgroundStyle(.supportOverlay)
        }
    }
    private var deadlineCell: some View {
        VStack {
            Toggle(isOn: $viewModel.isDeadlineEnabled.animation()) {
                Text("deadline")
                    .foregroundStyle(.labelPrimary)
                    .truncationMode(.tail)
            }
            if viewModel.isDeadlineEnabled {
                HStack {
                    Text(
                        viewModel.selectedDeadline.formatted(
                            .dateTime
                                .day(.twoDigits)
                                .month(.wide)
                                .year()
                        )
                    )
                    .foregroundStyle(.blue)
                    Spacer()
                }
            }
        }
    }
    private var datePickerCell: some View {
        DatePicker(
            "",
            selection: $viewModel.selectedDeadline,
            displayedComponents: .date
        )
        .datePickerStyle(.graphical)
    }

    private var deleteButtonCell: some View {
        Button {
            viewModel.removeItem()
            dismiss()
        } label: {
            Text("delete")
                .frame(maxWidth: .infinity)
                .foregroundStyle(viewModel.isItemNew ? .labelTertiary : .red)
        }
        .disabled(viewModel.isItemNew)
    }

    private var confirmation: some View {
        Button(role: .destructive) {
            viewModel.isAlertShown.toggle()
            dismiss()
        } label: {
            Text("task.discardChanges")
        }
    }
}

