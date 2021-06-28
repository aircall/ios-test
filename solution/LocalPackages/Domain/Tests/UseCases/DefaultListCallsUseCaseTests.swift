//
//  DefaultListCallsUseCaseTests.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

@testable import Domain
import Foundation
import XCTest

final class DefaultListCallsUseCaseTests: XCTestCase {

    func testListCallsCompletesWithListOfUnarchivedCalls() {
        // Arrange
        let mockCallsRepository = MockCallsRepository()
        let sut = DefaultListCallsUseCase(callsRepository: mockCallsRepository)

        // Act
        sut.execute { result in

            // Assert
            switch result {
            case let .success(calls):
                XCTAssertGreaterThan(calls.count, 0)
                let archivedCalls = calls.filter { $0.isArchived }
                let unarchivedCalls = calls.filter { !$0.isArchived }
                XCTAssertEqual(archivedCalls.count, 0)
                XCTAssertEqual(unarchivedCalls.count, calls.count)
            case .failure:
                XCTFail("Expected to succeed with list of calls")
            }
        }
    }

    func testListCallsFailsIfRepositoryFails() {
        // Arrange
        let mockCallsRepository = MockCallsRepository()
        mockCallsRepository.error = MockCallsRepositoryError.test
        let sut = DefaultListCallsUseCase(callsRepository: mockCallsRepository)

        // Act
        sut.execute { result in

            // Assert
            switch result {
            case .success:
                XCTFail("Expected to fail but succeeded")
            case let .failure(error):
                if let error = error as? MockCallsRepositoryError {
                    XCTAssertEqual(error, .test)
                } else {
                    XCTFail("Expected a different error")
                }
            }
        }
    }
}
