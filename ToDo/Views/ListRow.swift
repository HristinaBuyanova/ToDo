
import SwiftUI

struct ListRow: View {
    var item: TodoItem

    var body: some View {
        HStack(spacing: 10) {
            CircleImage()
            TextView()
            Spacer()
            ChevronImage()
        }
    }

    private func TextView() -> some View {
        VStack (alignment: .leading) {
            Text(item.text)
            if let deadline = item.deadline {
                HStack {
                    Image(systemName: "calendar")
                    Text(deadline.string())
                }
                .foregroundStyle(.gray)
            }

        }
        .font(.system(size: 17))
    }

    private func CircleImage() -> some View {
        Image(systemName:
                item.isDone ? "checkmark.circle.fill" :
                "circle"
        )
        .resizable()
        .foregroundStyle(item.isDone ? .green : .gray)
        .frame(width: 24, height: 24)
    }

    private func ChevronImage() -> some View {
        Image(systemName: "chevron.right")
            .resizable()
            .foregroundStyle(.gray)
            .frame(width: 7, height: 12)
            .bold()
    }
}

#Preview {
    ListRow(item: data[0])
        .padding()
}

let data = [TodoItem(text: "Купить хлеб", important: .important, deadline: Date())]
func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM"
    dateFormatter.locale = Locale(identifier: "ru_RU")
    return dateFormatter.string(from: date)
}
