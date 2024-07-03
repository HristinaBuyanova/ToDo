
import SwiftUI

struct ListRow: View {
    @Binding var toDoItem: TodoItem

    let onComplete: () -> Void

    var body: some View {
        HStack {
            CheckmarkView(toDoItem: $toDoItem, onComplete: onComplete)

            VStack(alignment: .leading) {
                HStack {
                    if toDoItem.important == .important {
                        Image(systemName: "exclamationmark.2")
                            .fontWeight(.bold)
                            .foregroundStyle(toDoItem.isDone ? Color.secondary : .red)
                    } else if toDoItem.important == .unimportant {
                        Image(systemName: "arrow.down")
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }

                    Text(toDoItem.text)
                        .strikethrough(toDoItem.isDone, color: .secondary)
                        .foregroundStyle(toDoItem.isDone ? .secondary : .primary)
                        .lineLimit(3)
                }

                if let deadline = toDoItem.deadline {
                    HStack {
                        Image(systemName: "calendar")
                        Text(
                            deadline
                            .formatted(
                                .dateTime.day().month().year()
                                .locale(.init(identifier: "ru_RU"))
                            )
                        )
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            .alignmentGuide(.listRowSeparatorLeading, computeValue: { dimension in
                return 0
            })
            .padding(.leading, 8)

            if let hex = toDoItem.color {
                Spacer()

                Rectangle()
                    .fill(Color(hex: hex))
                    .clipShape(.capsule)
                    .frame(width: 5)
                    .padding(.vertical, 8)
            }
        }
    }
}

#Preview {
    ListRow(toDoItem: .constant(FileCache.data[1]), onComplete: {})
}

struct CheckmarkView: View {
    @Binding var toDoItem: TodoItem

    let size: CGFloat = 24
    let onComplete: () -> Void

    var body: some View {
        Button {
            withAnimation(.interactiveSpring) {
                updateToDoItem()
            }
        } label: {
            if toDoItem.isDone {
                Circle()
                    .fill(.green)
                    .frame(width: size, height: size)
                    .overlay {
                        Image(systemName: "checkmark")
                            .resizable()
                            .fontWeight(.black)
                            .foregroundStyle(.white)
                            .frame(width: size * 0.5, height: size * 0.5)
                    }
            } else {
                Circle()
                    .fill(toDoItem.important == .important ? .red.opacity(0.1) : .clear)
                    .strokeBorder(lineWidth: 1.5)
                    .foregroundStyle(toDoItem.important == .important ? .red : .primary.opacity(0.2))
                    .frame(width: size, height: size)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func updateToDoItem() {
        toDoItem = TodoItem(
            id: toDoItem.id,
            text: toDoItem.text,
            important: toDoItem.important,
            deadline: toDoItem.deadline,
            isDone: !toDoItem.isDone, 
            color: toDoItem.color,
            creationDate: toDoItem.creationDate,
            modifiedDate: toDoItem.modifiedDate
        )

        onComplete()
    }
}
