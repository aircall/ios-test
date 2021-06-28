//
//  JSONEncoderExtensionsTests.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import XCTest

final class JSONEncoderExtensionsTests: XCTestCase {

    func testJSONEncoderEncodesDateCorrectly() throws {
        // Arrange
        let testData: DateEncodingTestData = .default
        let date = testData.date
        let expected = testData.jsonData

        // Act
        let actual = try JSONEncoder.withFullISO8601Strategy.encode(date)

        // Assert
        XCTAssertEqual(expected, actual)
    }
}
