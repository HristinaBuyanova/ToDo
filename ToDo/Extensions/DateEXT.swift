
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
}
