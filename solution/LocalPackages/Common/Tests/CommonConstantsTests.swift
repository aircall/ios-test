//
//  CommonConstantsTests.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import XCTest

final class CommonConstantsTests: XCTestCase {

    func testEmptyStringIsReallyEmpty() {
        // Arrange
        let expected = ""

        // Act
        let actual = CommonConstants.emptyString

        // Assert
        XCTAssertEqual(expected, actual)
    }

    func testJSONExtensionIsCorrect() {
        // Arrange
        let expected = "json"

        // Act
        let actual = CommonConstants.jsonExtension

        // Assert
        XCTAssertEqual(expected, actual)
    }
}
