//
//  DefaultNetworkServiceTests.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Combine
import Foundation
@testable import Networking
import XCTest

final class DefaultNetworkServiceTests: XCTestCase {

    private var config: APIDataNetworkConfig!
    private var mockNetworkSession: MockNetworkSession!
    private var sut: DefaultNetworkService!
    private var disposeBag: [AnyCancellable] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkSession = MockNetworkSession()
        guard let url = URL(string: "https://aircall.io/") else {
            XCTFail("Failed to initialize MockNetworkSession configuration")
            return
        }
        config = APIDataNetworkConfig(baseURL: url)
        sut = DefaultNetworkService(session: mockNetworkSession, config: config)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockNetworkSession = nil
        config = nil
        try super.tearDownWithError()
    }

    func testInvalidRequestThrowsError() throws {
        // Arrange
        mockNetworkSession.error = NetworkError.unknown
        let endpoint = DataEndpoint<Data>(path: "%$@%INVALID_PATH∂±$#")
        let expectedError = XCTestExpectation(description: "Request finished with expected error")
        let expectations = [expectedError]

        // Act
        sut.request(endpoint: endpoint) { result in

            // Assert
            switch result {
            case .success:
                XCTFail("Expected to fail but succeeded")
            case let .failure(error):
                if case NetworkError.urlGeneration = error {
                    expectedError.fulfill()
                }
            }
        }?.store(in: &disposeBag)

        wait(for: expectations, timeout: 4)
    }

    func testUnsuccessfullRequestReturnsError() throws {
        // Arrange
        mockNetworkSession.error = NetworkError.unknown
        let endpoint = DataEndpoint<Data>(path: "activities")
        let expectedError = XCTestExpectation(description: "Request finished with expected error")
        let expectations = [expectedError]

        // Act
        sut.request(endpoint: endpoint) { result in

            // Assert
            switch result {
            case .success:
                XCTFail("Expected to fail but succeeded")
            case .failure:
                expectedError.fulfill()
            }
        }?.store(in: &disposeBag)

        wait(for: expectations, timeout: 4)
    }

    func testRequestNotFoundReturnsError() {
        // Arrange
        mockNetworkSession.error = NetworkError.errorStatusCode(404)
        mockNetworkSession.httpResponse = HTTPURLResponse(url: config.baseURL,
                                                          statusCode: 404,
                                                          httpVersion: "2.0",
                                                          headerFields: [:])
        let expectedError = XCTestExpectation(description: "Request finished with expected error")
        let expectations = [expectedError]
        let endpoint = DataEndpoint<Data>(path: "activities")

        // Act
        sut.request(endpoint: endpoint) { result in

            // Assert
            switch result {
            case .success:
                XCTFail("Expected to fail but succeeded")
            case let .failure(error):
                if case let NetworkError.errorStatusCode(statusCode) = error,
                   statusCode == 404 {
                    expectedError.fulfill()
                } else {
                    XCTFail("Expected a different error")
                }
            }
        }?.store(in: &disposeBag)

        wait(for: expectations, timeout: 4)
    }

    func testRequestFailsWhenNotConnectedToTheInternet() {
        // Arrange
        mockNetworkSession.error = NSError(domain: NSURLErrorDomain,
                                           code: NSURLErrorNotConnectedToInternet,
                                           userInfo: nil)
        let expectedError = XCTestExpectation(description: "Request finished with expected error")
        let expectations = [expectedError]
        let endpoint = DataEndpoint<Data>(path: "activities")

        // Act
        sut.request(endpoint: endpoint) { result in

            // Assert
            switch result {
            case .success:
                XCTFail("Expected to fail but succeeded")
            case let .failure(error):
                if case NetworkError.notConnected = error {
                    expectedError.fulfill()
                }
            }
        }?.store(in: &disposeBag)

        wait(for: expectations, timeout: 4)
    }

    func testRequestFailsWhenCancelled() {
        // Arrange
        mockNetworkSession.error = NSError(domain: NSURLErrorDomain,
                                           code: NSURLErrorCancelled,
                                           userInfo: nil)
        let expectedError = XCTestExpectation(description: "Request finished with expected error")
        let expectations = [expectedError]
        let endpoint = DataEndpoint<Data>(path: "activities")

        // Act
        sut.request(endpoint: endpoint) { result in

            // Assert
            switch result {
            case .success:
                XCTFail("Expected to fail but succeeded")
            case let .failure(error):
                if case NetworkError.cancelled = error {
                    expectedError.fulfill()
                }
            }
        }?.store(in: &disposeBag)

        wait(for: expectations, timeout: 4)
    }

    func testSuccessfullRequestReturnsData() {
        // Arrange
        let expectedResponseData = XCTestExpectation(description: "Request finished with expected error")
        let expectations = [expectedResponseData]
        let endpoint = DataEndpoint<Data>(path: "activities")

        // Act
        sut.request(endpoint: endpoint) { result in

            // Assert
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
                XCTAssertGreaterThan(data?.count ?? 0, 0)
                expectedResponseData.fulfill()
            case .failure:
                XCTFail("Expected to succeed but failed")
            }
        }?.store(in: &disposeBag)

        wait(for: expectations, timeout: 4)
    }
}
