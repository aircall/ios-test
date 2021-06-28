//
//  DefaultArchivingCallUseCaseTests.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

@testable import Domain
import Foundation
import XCTest

final class DefaultArchivingCallUseCaseTests: XCTestCase {

    private var mockCallsRepository: CallsRepository!
    private var sut: DefaultArchivingCallUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCallsRepository = MockCallsRepository()
        sut = DefaultArchivingCallUseCase(callsRepository: mockCallsRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockCallsRepository = nil
        try super.tearDownWithError()
    }

    func testArchivingCallCompletesWithArchivedCall() {
        // Arrange
        let call = MockedEntities.calls[0]

        // Act
        sut.archiveCall(with: call.id, archive: true) { result in

            // Assert
            switch result {
            case let .success(call):
                XCTAssertTrue(call.isArchived)
            case .failure:
                XCTFail("Expected to succeed with archived call")
            }
        }
    }

    func testUnarchivingCallCompletesWithUnarchivedCall() {
        // Arrange
        let call = MockedEntities.calls[0]

        // Act
        sut.archiveCall(with: call.id, archive: false) { result in

            // Assert
            switch result {
            case let .success(call):
                XCTAssertFalse(call.isArchived)
            case .failure:
                XCTFail("Expected to succeed with archived call")
            }
        }
    }
}
