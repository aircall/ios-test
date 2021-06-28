//
//  FormattersTests.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 28/06/2021.
//

import XCTest
@testable import Aircall_iOS_Test

class FormattersTests: XCTestCase {

  func testOneInit() throws {

    XCTAssertEqual(Formatters.shared.iso8601DateFormatter, Formatters.shared.iso8601DateFormatter)
    XCTAssertEqual(Unmanaged.passUnretained(Formatters.shared.iso8601DateFormatter).toOpaque(),
                   Unmanaged.passUnretained(Formatters.shared.iso8601DateFormatter).toOpaque())
    XCTAssertEqual(Formatters.shared.shortDateTimeFormatter, Formatters.shared.shortDateTimeFormatter)
    XCTAssertEqual(Unmanaged.passUnretained(Formatters.shared.shortDateTimeFormatter).toOpaque(),
                   Unmanaged.passUnretained(Formatters.shared.shortDateTimeFormatter).toOpaque())
    XCTAssertEqual(Formatters.shared.longDateTimeFormatter, Formatters.shared.longDateTimeFormatter)
    XCTAssertEqual(Unmanaged.passUnretained(Formatters.shared.longDateTimeFormatter).toOpaque(),
                   Unmanaged.passUnretained(Formatters.shared.longDateTimeFormatter).toOpaque())
    XCTAssertEqual(Formatters.shared.dateComponentsFormatter, Formatters.shared.dateComponentsFormatter)
    XCTAssertEqual(Unmanaged.passUnretained(Formatters.shared.dateComponentsFormatter).toOpaque(),
                   Unmanaged.passUnretained(Formatters.shared.dateComponentsFormatter).toOpaque())
  }


}
