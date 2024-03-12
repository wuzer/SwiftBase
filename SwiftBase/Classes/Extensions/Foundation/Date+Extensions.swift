//
//  Date+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

class DateFormattersManager {
    static var dateFormatters: SynchronizedDictionary = SynchronizedDictionary<String, DateFormatter>()
}

public extension Date {
    static let minutesInAWeek = 24 * 60 * 7

    /// 通过字符串构造Date
    init?(fromString string: String,
          format: String,
          timezone: TimeZone = TimeZone.autoupdatingCurrent,
          locale: Locale = Locale.current) {
        if let dateFormatter = DateFormattersManager.dateFormatters.getValue(for: format) {
            if let date = dateFormatter.date(from: string) {
                self = date
            } else {
                return nil
            }
        } else {
            let formatter = DateFormatter()
            formatter.timeZone = timezone
            formatter.locale = locale
            formatter.dateFormat = format
            DateFormattersManager.dateFormatters.setValue(for: format, value: formatter)
            if let date = formatter.date(from: string) {
                self = date
            } else {
                return nil
            }
        }
    }

    /// 通过字符串构造Date
    init?(httpDateString: String) {
        if let rfc1123 = Date(fromString: httpDateString, format: "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz") {
            self = rfc1123
            return
        }
        if let rfc850 = Date(fromString: httpDateString, format: "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z") {
            self = rfc850
            return
        }
        if let asctime = Date(fromString: httpDateString, format: "EEE MMM d HH':'mm':'ss yyyy") {
            self = asctime
            return
        }
        if let iso8601DateOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd") {
            self = iso8601DateOnly
            return
        }
        if let iso8601DateHrMinOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mmxxxxx") {
            self = iso8601DateHrMinOnly
            return
        }
        if let iso8601DateHrMinSecOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ssxxxxx") {
            self = iso8601DateHrMinSecOnly
            return
        }
        if let iso8601DateHrMinSecMs = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx") {
            self = iso8601DateHrMinSecMs
            return
        }
        return nil
    }
    
    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier)// https://bugs.swift.org/browse/SR-10147
    }

    /// toString
    func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }

    /// toString
    func toString(format: String) -> String {
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self)
    }

    private func getDateFormatter(for format: String) -> DateFormatter {
        var dateFormatter: DateFormatter?
        if let _dateFormatter = DateFormattersManager.dateFormatters.getValue(for: format) {
            dateFormatter = _dateFormatter
        } else {
            dateFormatter = createDateFormatter(for: format)
        }

        return dateFormatter!
    }

    private func createDateFormatter(for format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        DateFormattersManager.dateFormatters.setValue(for: format, value: formatter)
        return formatter
    }

    /// 两个日期之间的天数
    func daysInBetweenDate(_ date: Date) -> Double {
        var diff = timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff / 86400)
        return diff
    }

    /// 两个日期之间的小时数
    func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff / 3600)
        return diff
    }

    /// 两个日期之间的分钟
    func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff / 60)
        return diff
    }

    /// 两个日期之间的秒
    func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff)
        return diff
    }

    /// 过去多少时间
    func timePassed() -> String {
        let date = Date()
        let calendar = Calendar.autoupdatingCurrent
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])

        if components.year! >= 1 {
            return "\(components.year!)年前"
        } else if components.month! >= 1 {
            return "\(components.month!)个月前"
        } else if components.day! >= 1 {
            return "\(components.day!)天前"
        } else if components.hour! >= 1 {
            return "\(components.hour!)小时前"
        } else if components.minute! >= 1 {
            return "\(components.minute!)分钟前"
        } else if components.second! >= 30 {
            return "\(components.second!)秒前"
        } else {
            return "刚刚"
        }
    }

    /// isFuture
    var isFuture: Bool {
        return self > Date()
    }

    /// isPast
    var isPast: Bool {
        return self < Date()
    }

    // isToday
    var isToday: Bool {
        let format = "yyyy-MM-dd"
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self) == dateFormatter.string(from: Date())
    }

    /// isYesterday
    var isYesterday: Bool {
        let format = "yyyy-MM-dd"
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self) == dateFormatter.string(from: yesterDay!)
    }

    /// isTomorrow
    var isTomorrow: Bool {
        let format = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let dateFormatter = getDateFormatter(for: format)

        return dateFormatter.string(from: self) == dateFormatter.string(from: tomorrow!)
    }

    /// isThisMonth
    var isThisMonth: Bool {
        let today = Date()
        return month == today.month && year == today.year
    }

    /// isThisWeek
    var isThisWeek: Bool {
        return minutesInBetweenDate(Date()) <= Double(Date.minutesInAWeek)
    }
    
    /// isInWeekend
    var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }

    // isWorkday
    var isWorkday: Bool {
        return !calendar.isDateInWeekend(self)
    }

    /// 获取era
    var era: Int {
        return Calendar.current.component(Calendar.Component.era, from: self)
    }

    /// 获取year
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }

    /// 获取month
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }

    /// 获取weekday
    var weekday: String {
        let format = "EEEE"
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self)
    }

    // 获取month
    var monthAsString: String {
        let format = "MMMM"
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self)
    }

    // 获取天
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    /// 获取小时
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }

    /// 获取分钟
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }

    /// 获取秒
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }

    /// 获取毫秒
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    /// 昨天
    var yesterday: Date {
        return calendar.date(byAdding: .day, value: -1, to: self) ?? Date()
    }

    /// 明天
    var tomorrow: Date {
        return calendar.date(byAdding: .day, value: 1, to: self) ?? Date()
    }

    /// 10位时间戳
    var unixTimestamp: Double {
        return timeIntervalSince1970
    }
}

// MARK: - Initializers
public extension Date {

    /// 构造方法
    ///
    /// eg. let date = Date(year: 2020, month: 1, day: 12) // "Jan 12, 2020, 7:45 PM"
    init?(
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = NSTimeZone.default,
        era: Int? = Date().era,
        year: Int? = Date().year,
        month: Int? = Date().month,
        day: Int? = Date().day,
        hour: Int? = Date().hour,
        minute: Int? = Date().minute,
        second: Int? = Date().second,
        nanosecond: Int? = Date().nanosecond) {

        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond

        guard let date = calendar?.date(from: components) else { return nil }
        self = date
    }

    /// 通过时间戳创建date
    ///
    /// eg. let date = Date(unixTimestamp: 1484239783.922743) // "Jan 12, 2017, 7:49 PM"
    init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }

    /// 通过Int创建date
    ///
    ///  eg. let date = Date(integerLiteral: 2019_12_25) // "2019-12-25 00:00:00 +0000"
    init?(integerLiteral value: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: String(value)) else { return nil }
        self = date
    }

}
