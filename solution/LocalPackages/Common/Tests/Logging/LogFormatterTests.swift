//
//  LogFormatterTests.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import XCTest

final class LogFormatterTests: XCTestCase {

    private var dateFormatter: DateFormatter!
    private var sut: LogFormatter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dateFormatter = .fullDateMilliseconds
        sut = LogFormatter(dateFormatter: dateFormatter)
    }

    override func tearDownWithError() throws {
        sut = nil
        dateFormatter = nil
        try super.tearDownWithError()
    }

    func testLogFormatterReturnsCorrectSymbolForKnownLogLevels() throws {
        // Arrange
        let testData: [(level: LogLevel, expectedSymbol: Character)] = [
            (level: .verbose, expectedSymbol: "🔬"),
            (level: .debug, expectedSymbol: "💬"),
            (level: .info, expectedSymbol: "ℹ️"),
            (level: .warning, expectedSymbol: "⚠️"),
            (level: .error, expectedSymbol: "‼️")
        ]

        for (level, expectedSymbol) in testData {
            // Act
            let actualSymbol = sut.symbol(for: level)

            // Assert
            XCTAssertEqual(expectedSymbol, actualSymbol)
        }
    }

    func testLogFormatterReturnsCorrectSymbolForUnknownLogLevels() throws {
        // Arrange
        let level = LogLevel(2)
        let expectedSymbol: Character = "👽"

        // Act
        let actualSymbol = sut.symbol(for: level)

        // Assert
        XCTAssertEqual(expectedSymbol, actualSymbol)
    }

    func testLogFormatterReturnsWellFormattedMessage() throws {
        // Arrange
        let message = "The truth is out there 👽"
        let level: LogLevel = .debug
        let levelSymbol: Character = sut.symbol(for: level)
        let date = Date(timeIntervalSince1970: TimeInterval(1624434641.9429832))
        let formattedDate = dateFormatter.string(from: date)
        let fileID: StaticString = #fileID
        let line: UInt = #line
        let column: UInt = #column
        let function: StaticString = #function
        let expectedFormattedMessage = "\(formattedDate) - [\(fileID):\(function) (\(line):\(column))]: \(levelSymbol) \(message)"

        // Act
        let formattedMessage = sut.format(message, level: level, date: date, fileID: fileID, line: line, column: column, function: function)

        // Assert
        XCTAssertEqual(formattedMessage, expectedFormattedMessage)
    }
}
