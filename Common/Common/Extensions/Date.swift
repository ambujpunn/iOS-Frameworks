//
//  Date.swift
//  Common
//
//  Created by Ambuj Punn on 5/29/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

public extension TimeInterval {
    static var minute: TimeInterval { 60 }
    static var hour: TimeInterval { 3600 }
    static var fiveMinutes: TimeInterval { TimeInterval.calculateSeconds(minutes: 5) }
    static var tenMinutes: TimeInterval { TimeInterval.calculateSeconds(minutes: 10) }
    static var fifteenMinutes: TimeInterval { TimeInterval.calculateSeconds(minutes: 15) }
    static var thirtyMinutes: TimeInterval { TimeInterval.calculateSeconds(minutes: 30) }

    static func calculateSeconds(minutes: Int) -> TimeInterval { TimeInterval(minutes) * minute }
}

public extension Date {
    /// Returns the current date
    static var now: Date {
        Date()
    }
    
    /// Returns a `TimeInterval` denoting the difference between the two dates
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
    }
}

public extension Date {
    /// “11/23/37”
    var short: String { DateFormatter.shortDateStyleFormat.string(from: self) }
    
    /// “Nov 23, 1937”
    var medium: String { DateFormatter.mediumDateStyleFormat.string(from: self) }
}

public extension Date {
    /// Returns the period of the day ("am" or "pm") based on the current locale
    func dayPeriod() -> DayPeriod {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("a")
        return DayPeriod(dateFormatter.string(from: self))
    }
}

public extension Date {
    /// No argument, default always calculating date from the start of Epoch time. Stating the obvious here since all dates started at that time so no need to have the argument. 
    init(_ timeSinceEpoch: TimeInterval) {
        self.init(timeIntervalSince1970: timeSinceEpoch)
    }
}

public extension Calendar {
    
    /// Represents the relation between the component and its value
    struct CalendarComponent {
        let component: Calendar.Component
        let value: Int
    }
   
    /// Returns multiple components in dictionary
    func components(_ components: [Calendar.Component], from date: Date) -> [CalendarComponent] {
        var foundComponents = [CalendarComponent]()
        components.forEach {
            foundComponents.append(.init(component: $0, value: component($0, from: date)))
        }
        return foundComponents
    }
}

public extension Sequence where Element == Calendar.CalendarComponent {
    subscript(component: Calendar.Component) -> Int? {
        return filter { $0.component == component }
            .map { $0.value }
            .first
    }
}

public enum DayPeriod: String {
    case am
    case pm
    case invalid
    
    init(_ rawValue: String) {
        switch rawValue.lowercased() {
        case "am": self = .am
        case "pm": self = .pm
        default: self = .invalid
        }
    }
}

public protocol TimeBuilding {
    var hour: Int { get set }
    var minute: Int { get set }
    var period: DayPeriod { get set }
}

public enum TimeBuildingError: String, Error {
    case invalid12HourFormat
    case invalidMinuteFormat
}

public struct TimeOfDay: TimeBuilding {
    public var hour: Int
    
    public var minute: Int
    
    public var period: DayPeriod
    
    public init(hour: Int, minute: Int, period: DayPeriod) throws {
        guard hour > 0 && hour <= 12 else { throw TimeBuildingError.invalid12HourFormat }
        guard minute >= 0 && minute < 60  else { throw TimeBuildingError.invalidMinuteFormat }
        self.hour = hour
        self.minute = minute
        self.period = period
    }
    
    public init(date: Date) {
        let components = Calendar.autoupdatingCurrent.components([.hour, .minute], from: date)
        // Using force unwrap here because components is being built by adding the components above^
        (hour, minute) = (components[.hour]!, components[.minute]!)
        period = date.dayPeriod()
    }
}

public extension TimeOfDay {
    var timeComponents: DateComponents {
        .init(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, hour: hour, minute: minute)
    }
}

extension TimeOfDay: CustomStringConvertible {
    /// Textual representation of the time "3:30 pm"
    public var description: String { "\(hour):\(minute < 10 ? "0\(minute)": "\(minute)") \(period)" }
}

extension TimeOfDay: Equatable {}
