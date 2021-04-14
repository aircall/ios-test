//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Rudy Frémont on 10/04/2021.
//

import XCTest
@testable import Networking

class NetworkingTests: XCTestCase {
    
    func testSuccessfullResponse() {
        // Setup our mock objects
        let session = MockURLSession()
        let manager = RequestManager(session: session)

        // Create data and tell the session to return it
        let data = Data(bytes: [0, 1, 0, 1], count: 4)
        session.nextData = data
        manager.sendRequest(requestFactory: MockUrlFactory()) { (result, _) in
            XCTAssertEqual(result, data)
        }
        manager.sendRequest(requestFactory: MockUrlFactory()) { (_, statusCode) in
            XCTAssertEqual(statusCode, .ok)
        }
    }
    
    func testFailedResponse() {
        // Setup our mock objects
        let session = MockURLSession()
        let manager = RequestManager(session: session)

        // Create an error and tell the session to return it
        session.nextError = MockError.error
        manager.sendRequest(requestFactory: MockUrlFactory()) { (_, statusCode) in
            XCTAssertEqual(statusCode, .serviceUnavailable)
        }
    }

}
