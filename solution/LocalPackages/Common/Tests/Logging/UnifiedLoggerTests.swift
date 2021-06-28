//
//  UnifiedLoggerTests.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import XCTest

final class UnifiedLoggerTests: XCTestCase {

    private var logFormatter: LogFormatter!
    private var sut: UnifiedLogger!

    override func setUpWithError() throws {
        try super.setUpWithError()
        logFormatter = LogFormatter(dateFormatter: .fullDateMilliseconds)
        sut = UnifiedLogger(level: .info, formatter: logFormatter)
    }

    override func tearDownWithError() throws {
        sut = nil
        logFormatter = nil
        try super.tearDownWithError()
    }

    func testUnifiedLoggerLogsMessageWithInfoLogLevel() throws {
        // Arrange
        let testData: LoggingTestData = .default

        // Act
        let logged = sut.log(testData.message,
                             level: .info,
                             date: testData.date,
                             fileID: testData.fileID,
                             line: testData.line,
                             column: testData.column,
                             function: testData.function)

        // Assert
        XCTAssertTrue(logged)
    }

    func testUnifiedLoggerLogsMessageWithErrorLogLevel() throws {
        // Arrange
        let testData: LoggingTestData = .default

        // Act
        let logged = sut.log(testData.message,
                             level: .error,
                             date: testData.date,
                             fileID: testData.fileID,
                             line: testData.line,
                             column: testData.column,
                             function: testData.function)

        // Assert
        XCTAssertTrue(logged)
    }

    func testUnifiedLoggerDoesNotLogMessageWithVerboseLogLevel() throws {
        // Arrange
        let testData: LoggingTestData = .default

        // Act
        let logged = sut.log(testData.message,
                             level: .verbose,
                             date: testData.date,
                             fileID: testData.fileID,
                             line: testData.line,
                             column: testData.column,
                             function: testData.function)

        // Assert
        XCTAssertFalse(logged)
    }
}
