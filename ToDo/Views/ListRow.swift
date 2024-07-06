
import SwiftUI

struct ListRow: View {

    let todoItem: TodoItem
    let color: Color?
    let onTap: () -> Void
    let onRadioButtonTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                radioButton
                    .padding(.trailing, 12)
                    .onTapGesture {
                        onRadioButtonTap()
                    }
                VStack(alignment: .leading) {
                    HStack {
                        if let priorityImage {
                            priorityImage
                        }
                        text
                    }
                    if let deadline = todoItem.deadline {
                        deadlineView(deadline)
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 5)
                Rectangle()
                    .fill(color ?? .clear)
                    .frame(width: 5)
                    .padding(.vertical, -5)
            }
        }
        .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
        .listRowSeparatorTint(.supportSeparator)
        .alignmentGuide(.listRowSeparatorLeading) { _ in
            46
        }

    }

    private var radioButton: Image {
        if todoItem.isDone {
            return Image(.done)
        }
        if todoItem.important == .important {
            return Image(.redCircle)
        }
        return Image(.grayCircle)
    }

    private var priorityImage: Image? {
        switch todoItem.important {
        case .unimportant:
            nil
        case .ordinary:
            nil
        case .important:
            Image(.low)
        }
    }

    private var text: some View {
        Text(todoItem.text)
            .foregroundStyle(todoItem.isDone ? .labelTertiary : .labelPrimary)
            .lineLimit(3)
            .truncationMode(.tail)
            .strikethrough(todoItem.isDone)
    }

    private func deadlineView(_ deadline: Date) -> some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundStyle(.labelTertiary)
            Text(deadline.string())
                .foregroundStyle(.labelTertiary)
        }
    }


}

#Preview {
    ListRow(
        todoItem: TodoItem(
            text: "Купить хлеб",
            important: .important,
            deadline: .now,
            isDone: false,
            creationDate: .now
        ),
        color: .red,
        onTap: {},
        onRadioButtonTap: {}
    )
}
