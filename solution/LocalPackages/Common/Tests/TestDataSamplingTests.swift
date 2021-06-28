//
//  TestDataSamplingTests.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

@testable import Common
import XCTest

final class TestDataSamplingTests: XCTestCase {

    func testTestDataSamplingFailsToLoadNonExistingFile() {
        // Arrange
        let fileName = "sample_get_calls"
        guard let file = FileDescription.json(with: fileName) else {
            XCTFail("Could not initialize sample JSON file named \(fileName)")
            return
        }

        // Act
        let sampleData = getSampleData(from: file, in: .module)

        // Assert
        XCTAssertNil(sampleData)
    }

    func testTestDataSamplingLoadsExistingFile() {
        // Arrange
        let fileName = "sample_get_activities"
        guard let file = FileDescription.json(with: fileName) else {
            XCTFail("Could not initialize sample JSON file named \(fileName)")
            return
        }

        // Act
        let sampleData = getSampleData(from: file, in: .module)

        // Assert
        XCTAssertNotNil(sampleData)
    }
}

extension TestDataSamplingTests: TestDataSampling { }
