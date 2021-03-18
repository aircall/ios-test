//
//  UIColor+NameTest.swift
//  AircallTests
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import XCTest
@testable import Aircall

class UIColorNameTest: XCTestCase {

  func testColorsExist() {
    XCTAssertEqual(
      UIColor.inboundIconColor,
      UIColor(named: "OutrageousOrange"),
      "Color not exist to tint inbound icon"
    )

    XCTAssertEqual(
      UIColor.outboundIconColor,
      UIColor(named: "PersianGreen"),
      "Color not exist to tint outbound icon"
    )
  }

}
