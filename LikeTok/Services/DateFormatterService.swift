import Foundation

final class AppDateFormatter {
    static let shared = AppDateFormatter()
    
    private init() {}
    
    private let deliveryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    let trackingDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()
    
    func trackingDateString(from date: Date) -> String {
        return trackingDateFormatter.string(from: date)
    }
    
    func estimatedDateString(from date: Date) -> String {
        return deliveryDateFormatter.string(from: date)
    }
    
    func expectedDeliveryTitle(from date: Date) -> String {
        let days = days(sinceDate: Date(), date: date)
        if days == 0 {
            let formatString: String = NSLocalizedString("details.estimated_time.today",
                                                          comment: "")
            return formatString
        }
        if days == 1 {
            let formatString: String = NSLocalizedString("details.estimated_time.tomorrow",
                                                          comment: "")
            return formatString
        }
        let formatString: String = NSLocalizedString("expected_delivery_string",
                                                      comment: "")
        let resultString: String = String.localizedStringWithFormat(formatString, days ?? 0)
        return resultString
    }
    
    func days(sinceDate: Date, date: Date) -> Int? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let roundedSince = calendar.startOfDay(for: sinceDate)
        let roundedFrom = calendar.startOfDay(for: date)
        return Calendar.current.dateComponents([.day], from: roundedSince, to: roundedFrom).day
    }
    
}
