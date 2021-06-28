//
//  CallResponseTests.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

@testable import Common
@testable import Data
import XCTest

final class CallResponseTests: XCTestCase {

    private var decoder: JSONDecoder!

    override func setUpWithError() throws {
        try super.setUpWithError()
        decoder = JSONDecoder.withFullISO8601Strategy
    }

    override func tearDownWithError() throws {
        decoder = nil
        try super.tearDownWithError()
    }

    func testSucceedDecodingValidSample() throws {
        // Arrange
        let testData: CallResponseTestData = .activityDetails
        guard let sampleData = getSampleData(from: testData.sampleFile, in: Bundle.module) else {
            XCTFail("Failed to read sample test data")
            return
        }
        guard let expected = testData.expectedCalls.first else {
            XCTFail("Failed to read test data")
            return
        }

        let actual = try decoder.decode(CallResponse.self, from: sampleData)

        // Assert
        XCTAssertEqual(expected, actual)
    }

    func testSucceedDecodingValidSampleWithArray() throws {
        // Arrange
        let testData: CallResponseTestData = .activities
        guard let sampleData = getSampleData(from: testData.sampleFile, in: Bundle.module) else {
            XCTFail("Failed to read sample test data")
            return
        }

        // Act
        let actualCalls = try decoder.decode([CallResponse].self, from: sampleData)

        // Assert
        XCTAssertEqual(testData.expectedCalls, actualCalls)
    }
}

extension CallResponseTests: TestDataSampling { }
