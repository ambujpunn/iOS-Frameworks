//
//  Day.swift
//  Common
//
//  Created by Ambuj Punn on 7/9/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import Foundation

public enum Day: String, CaseIterable {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    case invalid
    
    public init(_ rawValue: Int) {
        switch rawValue {
        case 1: self = .Sunday
        case 2: self = .Monday
        case 3: self = .Tuesday
        case 4: self = .Wednesday
        case 5: self = .Thursday
        case 6: self = .Friday
        case 7: self = .Saturday
        default: self = .invalid
        }
    }
}

public protocol DayBehavior {
    var weekValue: Int { get }
    static var weekdays: [Day] { get }
    static var weekends: [Day] { get }
}

public extension DayBehavior {
    static var weekdays: [Day] { Day.allCases.filter { $0 != .Saturday && $0 != .Sunday && $0 != .invalid } }
    static var weekends: [Day] { (Day.allCases.set - .invalid - weekdays).array }
}

extension Day: DayBehavior {
    public var weekValue: Int {
        // Could easily change Day to be Int type but then more work to type full String. Ordering of values for String raw value purposes does not matter, however for Int raw value purposes it does so it makes sense to have the week value be strictly checking each case of the Day type
        switch self {
        case .Sunday: return 1
        case .Monday: return 2
        case .Tuesday: return 3
        case .Wednesday: return 4
        case .Thursday: return 5
        case .Friday: return 6
        case .Saturday: return 7
        case .invalid: return -1
        }
    }
}

extension Day: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: Int) {
        self = Day(value)
    }
}
