import Foundation

extension Date {

    init?(anyTimeIntervalSince1970: Any?) {
        if let dueDateInterval = anyTimeIntervalSince1970 as? TimeInterval {
            self.init(timeIntervalSince1970: dueDateInterval)
        } else if let anyTimeIntervalSince1970 = anyTimeIntervalSince1970 as? String,
                  let dueDateInterval = TimeInterval(anyTimeIntervalSince1970) {
            self.init(timeIntervalSince1970: dueDateInterval)
        } else {
            return nil
        }
    }

    func string() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }

    static var nextDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: .now)!.stripTime()
    }

    var dayAndMonthString: String {
        formatted(.dateTime.day(.twoDigits).month(.abbreviated))
    }

    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
}
