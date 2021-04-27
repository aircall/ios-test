//
//  DateTests.swift
//  AircallLaurentTests
//
//  Created by Laurent on 26/04/2021.
//

import XCTest

class DateTests: XCTestCase {

  func test_iso8601_to_date() throws {
    let iso8601Date = "2018-04-18T16:59:48.000Z"
    guard let date = Date(fromISO8601: iso8601Date) else {
      XCTFail("Unable to convert iso8601 date to Date")
      return
    }

    let expectedTimestamp: TimeInterval = 1524070788

    XCTAssert(date.timeIntervalSince1970 == expectedTimestamp)
  }

  func test_date_to_time_string() throws {
    let timeStamp: TimeInterval = 1524070788

    let date = Date(timeIntervalSince1970: timeStamp)
    let resultTime = date.timeIn24HourFormat

    let expectedTime = "18:59"
    XCTAssert(resultTime == expectedTime)
  }

  func test_date_to_day_string() throws {
    let timeStamp: TimeInterval = 1524070788

    let date = Date(timeIntervalSince1970: timeStamp)
    let resultMonthDay = date.monthDayShortFormat

    let expectedMonthDay = "Apr. 18"
    XCTAssert(resultMonthDay == expectedMonthDay)
  }

}
