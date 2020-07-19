//
//  DurationConverterTests.swift
//  AircallTests
//
//  Created by JC on 19/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import XCTest
@testable import Aircall

class DurationConverterTests: XCTestCase {
    func test__string__itDropLeadingAndTrailingZeros() {
        let duration = Duration.seconds(60)
        
        XCTAssertEqual(DurationConverter.string(duration: duration), "1m")
    }
}
