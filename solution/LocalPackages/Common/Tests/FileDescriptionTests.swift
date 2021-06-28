//
//  FileDescriptionTests.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

@testable import Common
import XCTest

final class FileDescriptionTests: XCTestCase {

    func testFileDescriptionInitializerFailsWithEmptyFileName() {
        // Arrange
        let fileName = CommonConstants.emptyString
        let fileExtension = "txt"

        // Act
        let sampleFile = FileDescription(name: fileName, extension: fileExtension)

        // Assert
        XCTAssertNil(sampleFile)
    }

    func testFileDescriptionInitializerFailsWithEmptyFileExtension() {
        // Arrange
        let fileName = "file_name"
        let fileExtension = CommonConstants.emptyString

        // Act
        let sampleFile = FileDescription(name: fileName, extension: fileExtension)

        // Assert
        XCTAssertNil(sampleFile)
    }

    func testFileDescriptionHasExpectedAttributes() {
        // Arrange
        let fileName = "file_name"
        let fileExtension = "txt"

        // Act
        let sampleFile = FileDescription(name: fileName, extension: fileExtension)

        // Assert
        guard let file = sampleFile else {
            XCTFail("File should not be nil")
            return
        }
        XCTAssertEqual(file.name, fileName)
        XCTAssertEqual(file.extension, fileExtension)
    }

    func testJSONFileDescriptionFailsWithEmptyFileName() {
        // Arrange
        let fileName = CommonConstants.emptyString

        // Act
        let sampleFile = FileDescription.json(with: fileName)

        // Assert
        XCTAssertNil(sampleFile)
    }

    func testJSONFileDescriptionHasCorrectAttributes() {
        // Arrange
        let fileName = "file_name"

        // Act
        let sampleFile = FileDescription.json(with: fileName)

        // Assert
        guard let file = sampleFile else {
            XCTFail("File should not be nil")
            return
        }
        XCTAssertEqual(file.name, fileName)
        XCTAssertEqual(file.extension, CommonConstants.jsonExtension)
    }
}
