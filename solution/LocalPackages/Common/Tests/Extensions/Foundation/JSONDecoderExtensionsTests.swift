//
//  JSONDecoderExtensionsTests.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import XCTest

final class JSONDecoderExtensionsTests: XCTestCase {

    func testDateFormatterParsesValidDateString() throws {
        // Arrange
        let testData: DateEncodingTestData = .default
        let expected = testData.date
        let jsonData = testData.jsonData

        // Act
        let actual = try JSONDecoder.withFullISO8601Strategy.decode(Date.self, from: jsonData)

        // Assert
        XCTAssertEqual(expected, actual)
    }

    func testDateFormatterFailsToParseInvalidDateString() throws {
        // Arrange
        let testData: DateEncodingTestData = .default
        let jsonData = testData.invalidJSONData

        // Act/Assert
        XCTAssertThrowsError(try JSONDecoder.withFullISO8601Strategy.decode(Date.self, from: jsonData))
    }
}
