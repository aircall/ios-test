//
//  ISO8601DateFormatterExtensionsTests.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import XCTest

final class ISO8601DateFormatterExtensionsTests: XCTestCase {

    func testDateFormatterParsesValidDateString() throws {
        // Arrange
        let testData: DateEncodingTestData = .default
        let expected = testData.date
        let dateString = testData.dateString

        // Act
        let actual = ISO8601DateFormatter.fullISO8601.date(from: dateString)

        // Assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected, actual)
    }

    func testDateFormatterPrintsDateCorrectly() throws {
        // Arrange
        let testData: DateEncodingTestData = .default
        let expected = testData.dateString
        let date = testData.date

        // Act
        let actual = ISO8601DateFormatter.fullISO8601.string(from: date)

        // Assert
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected, actual)
    }
}
