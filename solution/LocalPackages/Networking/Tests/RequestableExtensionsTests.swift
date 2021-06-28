//
//  RequestableExtensionsTests.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Combine
import Foundation
@testable import Networking
import XCTest

final class RequestableExtensionsTests: XCTestCase {

    private var config: NetworkConfigurable!

    override func setUpWithError() throws {
        try super.setUpWithError()
        guard let url = URL(string: "https://aircall.io/") else {
            XCTFail("Failed to initialize MockNetworkSession configuration")
            return
        }
        config = APIDataNetworkConfig(baseURL: url)
    }

    override func tearDownWithError() throws {
        config = nil
        try super.tearDownWithError()
    }

    func testInvalidEndpointFailsRequest() {
        // Arrange
        let endpoint = DataEndpoint<Data>(path: "%$@%INVALID_PATH∂±$#")

        // Act / Assert
        XCTAssertThrowsError(try endpoint.urlRequest(with: config))
    }

    func testValidEndpointCreatesRequest() {
        // Arrange
        let endpoint = DataEndpoint<Data>(path: "activities")

        // Act / Assert
        XCTAssertNoThrow(try endpoint.urlRequest(with: config))
    }
}
