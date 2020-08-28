//
//  DateTests.swift
//  CommonTests
//
//  Created by Ambuj Punn on 7/13/20.
//  Copyright © 2020 Ambuj Punn. All rights reserved.
//

import XCTest
@testable import Common

class DateTests: XCTestCase {

    func testTimeOfDay() throws {
        var timeOfDay = try TimeOfDay(hour: 3, minute: 1, period: .am)
        XCTAssertEqual(timeOfDay.description, "3:01 am")
        timeOfDay = try TimeOfDay(hour: 11, minute: 15, period: .pm)
        XCTAssertEqual(timeOfDay.description, "11:15 pm")
    }
    
    func testTimeOfDayErrors() throws {
        do {
            let _ = try TimeOfDay(hour: 13, minute: 1, period: .am)
        } catch {
            XCTAssertEqual(error.localizedDescription, TimeBuildingError.invalid12HourFormat.localizedDescription)
        }
        do {
            let _ = try TimeOfDay(hour: 11, minute: 64, period: .am)
        } catch {
            XCTAssertEqual(error.localizedDescription, TimeBuildingError.invalidMinuteFormat.localizedDescription)
        }
    }
    
    func testDays() throws {
        XCTAssertEqual(Day.weekends.set, [.Saturday, .Sunday].set)
        XCTAssertEqual(Day.weekdays.set, [.Monday, .Tuesday, .Wednesday, .Thursday, .Friday].set)
    }

}
