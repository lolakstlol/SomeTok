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
    
    private let backDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)!
        return formatter
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
    
    func getCurrentDateformat(with date: String) -> String? {
        let dateFormatterGet = backDateFormatter
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        
        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }
    
    func getCurrentDateOrTodayformat(with date: String) -> String? {
        let dateFormatterGet = backDateFormatter
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        
        if let date = dateFormatterGet.date(from: date) {
            return
                (Date().days(sinceDate: date) ?? 1) == .zero ? "Сегодня" : dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }
    
    func getCurrentTimeformat(with date: String) -> String? {
        let dateFormatterGet = backDateFormatter
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        
        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }
    
    func howLongAgoWithDate(with date: String) -> String? {
        guard let date = backDateFormatter.date(from: date) else { return nil }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekOfYear, .day, .hour, .minute],
                                                 from: date, to: Date())
        if let weeks = components.weekOfYear, weeks > 0 {
            return "· \(weeks)нед. назад"
        }
        if let days = components.day, days > 0 {
            return "· \(days)д. назад"
        }
        if let hours = components.hour, hours > 0 {
            return "· \(hours)ч. назад"
        }
        if let mins = components.minute, mins > 0 {
            return "· \(mins) мин. назад"
        } else {
            return "· Сейчас"
        }
    }
    
}
