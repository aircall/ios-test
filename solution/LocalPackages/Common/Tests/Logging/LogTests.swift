//
//  LogTests.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import XCTest

final class LogTests: XCTestCase {

    private var logFormatter: LogFormatter!
    private var errorOnlyLoggerStub: LoggerTypeStub!
    private var infoLoggerStub: LoggerTypeStub!
    private var verboseLoggerStub: LoggerTypeStub!
    private var sut: Log!

    override func setUpWithError() throws {
        try super.setUpWithError()
        logFormatter = LogFormatter(dateFormatter: .fullDateMilliseconds)
        errorOnlyLoggerStub = LoggerTypeStub(level: .error, formatter: logFormatter)
        infoLoggerStub = LoggerTypeStub(level: .info, formatter: logFormatter)
        verboseLoggerStub = LoggerTypeStub(level: .verbose, formatter: logFormatter)
        sut = Log(queue: Log.defaultQueue)
    }

    override func tearDownWithError() throws {
        sut = nil
        verboseLoggerStub = nil
        infoLoggerStub = nil
        errorOnlyLoggerStub = nil
        logFormatter = nil
        try super.tearDownWithError()
    }

    func testLoggersAreSetup() throws {
        // Arrange
        try sut.setupLoggers([errorOnlyLoggerStub, infoLoggerStub, verboseLoggerStub])

        // Act
        let registeredLoggers = sut.loggers

        // Assert
        XCTAssertNotNil(registeredLoggers)
        XCTAssertEqual(3, registeredLoggers?.count)
    }

    func testLoggersCanOnlyBeSetupOnce() throws {
        // Arrange
        try sut.setupLoggers([errorOnlyLoggerStub, infoLoggerStub, verboseLoggerStub])

        // Act/Assert
        XCTAssertThrowsError(try sut.setupLoggers([verboseLoggerStub]))
    }

    func testLoggersDoNotLogIfNotSetup() throws {
        // Arrange
        let testData: LoggingTestData = .default

        // Act
        let logFinished = XCTestExpectation(description: "Log should return earlier if no loggers are setup")
        sut.log(testData.message, level: .info) { [weak self] in
            // Assert
            logFinished.fulfill()
            XCTAssertNil(self?.errorOnlyLoggerStub.formattedMessage)
            XCTAssertNil(self?.infoLoggerStub.formattedMessage)
            XCTAssertNil(self?.verboseLoggerStub.formattedMessage)
        }

        wait(for: [logFinished], timeout: 0.0003)
    }

    func testCompatibleLoggersLogMessage() throws {
        // Arrange
        try sut.setupLoggers([errorOnlyLoggerStub, infoLoggerStub, verboseLoggerStub])
        let testData: LoggingTestData = .default

        // Act
        let logFinished = XCTestExpectation(description: "Logs should be dispatched to each registered logger")
        sut.log(testData.message, level: .info) { [weak self] in
            // Assert
            logFinished.fulfill()
            XCTAssertNil(self?.errorOnlyLoggerStub.formattedMessage)
            XCTAssertNotNil(self?.infoLoggerStub.formattedMessage)
            XCTAssertNotNil(self?.verboseLoggerStub.formattedMessage)
        }

        wait(for: [logFinished], timeout: 0.0003)
    }
}
