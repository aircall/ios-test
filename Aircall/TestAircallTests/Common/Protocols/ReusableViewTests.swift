//
//  ReusableViewTests.swift
//  TestAircallTests
//
//  Created by Delphine Garcia on 25/06/2021.
//

import XCTest
@testable import TestAircall

class MockReusableView: ReusableView {}

class ReusableViewTests: XCTestCase {
    
    func testReuseIdentifier() {
        XCTAssertEqual(MockReusableView.reuseIdentifier, "MockReusableView")
    }
}
