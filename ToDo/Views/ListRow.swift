
import SwiftUI

struct ListRow: View {
    var item: TodoItem

    var body: some View {
        HStack(spacing: 10) {
            CircleImage()
            if item.important == .important && !item.isDone {
                ExclamationMarkImage()
            }
            TextView()
            Spacer()
            ChevronImage()
        }
    }

    private func TextView() -> some View {
        VStack (alignment: .leading) {
            if item.isDone {
                Text(item.text)
                    .strikethrough()
                    .font(.system(size: 17))
                    .foregroundStyle(Color.labelTertiary)
            } else {
                Text(item.text)
                    .font(.system(size: 17))
                    .foregroundStyle(Color.labelPrimary)
                if let deadline = item.deadline {
                    HStack {
                        Image(systemName: "calendar")
                        Text(deadline.string())
                    }
                    .font(.system(size: 15))
                    .foregroundStyle(Color.labelTertiary)
                }
            }
        }
    }

    private func CircleImage() -> some View {
        if item.important != .important {
            Image(systemName:
                    item.isDone ? "checkmark.circle.fill" :
                    "circle"
            )
            .resizable()
            .foregroundStyle(item.isDone ? Color.green : Color.supportSeparator)
            .frame(width: 24, height: 24)
        } else {
            Image(systemName:
                    item.isDone ? "checkmark.circle.fill" :
                    "circle"
            )
            .resizable()
            .foregroundStyle(item.isDone ? Color.green : Color.red)
            .frame(width: 24, height: 24)
        }
        }

    private func ChevronImage() -> some View {
        Image(systemName: "chevron.right")
            .resizable()
            .foregroundStyle(.gray)
            .frame(width: 7, height: 12)
            .bold()
    }

    private func ExclamationMarkImage() -> some View {
        Image(systemName: "exclamationmark.2")
            .fontWeight(.bold)
            .foregroundColor(.red)
            .font(.system(size: 24))
    }
}

#Preview {
    ListRow(item: ViewModel().data[0])
        .padding()
}


