//
//  String+DateTest.swift
//  AircallTests
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import XCTest
@testable import Aircall

class StringDateTest: XCTestCase {

  func testMonthFormat() {
    XCTAssertEqual(
      "2018-04-19T09:38:41.000Z".getFormattedDate(format: "MMM"),
      "Apr",
      "Month should be Apr"
    )
  }

  func testYearFormat() {
    XCTAssertEqual(
      "2018-04-19T09:38:41.000Z".getFormattedDate(format: "YYY"),
      "2018",
      "Year should be 2018"
    )
  }

  func testDateFormat() {
    XCTAssertEqual(
      "2018-04-19T09:38:41.000Z".getFormattedDate(format: "dd/MM/yyyy"),
      "19/04/2018",
      "Date should be 19/04/2018"
    )
  }

  func testMonthDateAndTimeFormat() {
    XCTAssertEqual(
      "2018-04-19T09:38:41.000Z".getFormattedDate(format: "MMM d, HH:mm"),
      "Apr 19, 11:38",
      "Result should be Apr 19, 11:38"
    )
  }

}
