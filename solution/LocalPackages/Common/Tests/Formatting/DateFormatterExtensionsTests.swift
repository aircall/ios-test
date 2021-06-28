//
//  DateFormatterExtensionsTests.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import XCTest

final class DateFormatterExtensionsTests: XCTestCase {

    func testDateFormatterFullDateWithMillisecondsIsCorrect() {
        // Arrange
        let date = Date(timeIntervalSince1970: TimeInterval(1624434641.9429832))
        let expected = "2021-06-23 09:50:41.9430"

        // Act
        let actual = DateFormatter.fullDateMilliseconds.string(from: date)

        // Assert
        XCTAssertEqual(expected, actual)
    }
}
