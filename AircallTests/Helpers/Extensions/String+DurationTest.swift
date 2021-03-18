//
//  String+DurationTest.swift
//  AircallTests
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import XCTest
@testable import Aircall

class StringDurationTest: XCTestCase {

  func testMintuesDuration() {
    XCTAssertEqual(
      "180".getDuration(),
      "(3 min)",
      "Result should be (3 min)"
    )
  }

  func testOneMinuteDuration() {
    XCTAssertEqual(
      "60".getDuration(),
      "(1 min)",
      "Result should be (1 min)"
    )
  }

  func testSecondDuration() {
    XCTAssertEqual(
      "59".getDuration(),
      "(59 sec)",
      "Result should be (59 sec)"
    )
  }

  func testLessThanTwoSecondDuration() {
    XCTAssertEqual(
      "1".getDuration(),
      "(1 sec)",
      "Result should be (1 sec)"
    )
  }

}
