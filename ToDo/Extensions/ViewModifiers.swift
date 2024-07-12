import SwiftUI

extension View {

    func markableAsDone(isDone: Bool, onAction: @escaping () -> Void) -> some View {
        modifier(MarkAsDoneSwipe(isDone: isDone, onAction: onAction))
    }

    func groupedList() -> some View {
        modifier(GroupedList())
    }

    func deletable(onAction: @escaping () -> Void) -> some View {
        modifier(DeleteSwipe(onAction: onAction))
    }

    func withInfo(onAction: @escaping () -> Void) -> some View {
        modifier(InfoSwipe(onAction: onAction))
    }

}

struct DeleteSwipe: ViewModifier {

    var onAction: () -> Void

    func body(content: Content) -> some View {
        content.swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                onAction()
            } label: {
                Label("delete", systemImage: "trash")
            }
            .tint(.red)
        }
    }

}

struct InfoSwipe: ViewModifier {

    var onAction: () -> Void

    func body(content: Content) -> some View {
        content.swipeActions(edge: .trailing) {
            Button {
                onAction()
            } label: {
                Label("info", systemImage: "info.circle.fill")
            }
            .tint(.myGrayLight)
        }
    }

}

struct MarkAsDoneSwipe: ViewModifier {

    var isDone: Bool
    var onAction: () -> Void

    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .leading) {
                Button(role: .cancel) {
                    onAction()
                } label: {
                    if isDone {
                        undoneLabel
                    } else {
                        doneLabel
                    }
                }
            }
    }

    private var doneLabel: some View {
        label(text: "done", tint: .green, systemImage: "checkmark.circle.fill")
    }

    private var undoneLabel: some View {
        label(text: "undone", tint: .red, systemImage: "x.circle.fill")
    }

    private func label(text: LocalizedStringKey, tint: Color, systemImage: String) -> some View {
        Label(text, systemImage: systemImage).tint(tint)
    }

}

struct GroupedList: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(.backPrimary)
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
    }

}
