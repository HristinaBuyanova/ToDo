
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
                        categoryCell
                        deadlineCell
                        if viewModel.isDeadlineEnabled {
                            datePickerCell
                        }
                    }
                    Section {
                        deleteButtonCell
                    }
                }
                .listRowBackground(Color.backSecondary)
                .listRowSeparatorTint(.supportSeparator)
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
                  cancelButton
                }
                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
                    .disabled(!viewModel.canItemBeSaved)
                }
            }
        }
        .interactiveDismissDisabled(viewModel.canItemBeSaved)
    }

    var cancelButton: some View {
        Button {
            dismissIfNeeded()
        } label: {
            Text("cancel")
                .foregroundStyle(.blue)
        }
    }

    var saveButton: some View {
        Button {
            viewModel.saveItem()
            dismiss()
        } label: {
            Text("save")
                .foregroundStyle(viewModel.canItemBeSaved ? .blue : .labelTertiary)
                .bold()
        }
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

    private var categoryCell: some View {
        Button {
            viewModel.isCategoryViewShown.toggle()
        } label: {
            HStack {
                Text("category")
                    .foregroundStyle(.labelPrimary)
                    .truncationMode(.tail)
                Spacer()
                if let category = viewModel.category {
                    HStack(spacing: 1) {
                        Text(category.text)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .foregroundStyle(.labelPrimary)
                        if let hex = category.color {
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .fill(Color(hex: hex))
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
    }
}

