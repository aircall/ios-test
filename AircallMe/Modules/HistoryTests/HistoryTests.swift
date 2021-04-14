//
//  HistoryTests.swift
//  HistoryTests
//
//  Created by Rudy Frémont on 10/04/2021.
//

import XCTest
@testable import History
import Rswift

/// Helper function to test if a Result variable is a success
/// - Parameters:
///   - result: the Result to test
///   - message: The message to display if result is not a success
func XCTIsSuccess<T, E>(_ result: Result<T, E>, _ message: String = "Expected to be a success") {
    
    if case .failure = result {
        XCTFail(message)
    }
}

/// Helper function to test if a Result variable is a failure
/// - Parameters:
///   - result: the Result to test
///   - message: The message to display if result is not a failure
func XCTIsFailure<T, E>(_ result: Result<T, E>, _ message: String = "Expected to be a failure") {
    
    if case .success = result {
        XCTFail(message)
    }
}

class HistoryTests: XCTestCase {

    /// R.Swift verify that all resources are available
    func testValidateRSwift() {
        do {
            try R.validate()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
