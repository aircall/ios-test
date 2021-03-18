//
//  UIImageView+ColorTest.swift
//  AircallTests
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import XCTest
@testable import Aircall

class UIImageViewColorTest: XCTestCase {

  func testImageColor() {
    let image = UIImageView(image: UIImage(named: "icon_inbound"))
    image.setImageColor(color: UIColor.inboundIconColor)

    XCTAssertEqual(
      image.tintColor,
      UIColor.inboundIconColor,
      "Image tint color should be inboundIconColor"
    )
  }

}
