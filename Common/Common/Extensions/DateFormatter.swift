//
//  DateFormatter.swift
//  Meditator
//
//  Created by Ambuj Punn on 6/9/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

protocol TimerDateFormatted {
    static func timerFormatter(timeElapsed: TimeInterval) -> DateFormatter
    static func formattedTimerDate(timeElapsed: TimeInterval) -> String
}

extension DateFormatter: TimerDateFormatted {
    public static func timerFormatter(timeElapsed: TimeInterval) -> DateFormatter {
        let dateFormatter = DateFormatter()
        var formatTemplate = "mm:ss"
        if timeElapsed >= TimeInterval.hour { formatTemplate = "hh:mm:ss" }
        // Use date format here because we don't want localized format (PST) that would include "am"/"pm"
        dateFormatter.dateFormat = formatTemplate
        // Use UTC format to make sure that we're getting epoch time since at UTC it starts at midnight
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }
    
    public static func formattedTimerDate(timeElapsed: TimeInterval) -> String {
        // Using trick/hack to get the format of the timer in string by getting the elapsed time from the epoch time
        let dateForTimer = Date(timeIntervalSince1970: timeElapsed)
        return DateFormatter.timerFormatter(timeElapsed: timeElapsed).string(from: dateForTimer)
    }
}

public extension DateFormatter {

    /// “11/23/37”
    static var shortDateStyleFormat: DateFormatter { dateStyleFormat(.short) }
    
    /// “Nov 23, 1937”
    static var mediumDateStyleFormat: DateFormatter { dateStyleFormat(.medium) }
    
    /// "3:30 PM"
    static var shortTimeStyleFormat: DateFormatter { timeStyleFormat(.short) }
    
    /// “3:30:32 PM”
    static var mediumTimeStyleFormat: DateFormatter { timeStyleFormat(.medium) }
    
    private static func dateStyleFormat(_ dateStyle: DateFormatter.Style) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
    
    private static func timeStyleFormat(_ timeStyle: DateFormatter.Style) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = timeStyle
        dateFormatter.dateStyle = .none
        return dateFormatter
    }
}
