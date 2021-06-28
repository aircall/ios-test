//
//  MockNetworkSession.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Common
import Combine
import Foundation

#if DEBUG
/**
 A mocked `NetworkSession`.
 */
final class MockNetworkSession: NetworkSession {

    /// An error the mock session should throw when executing the request.
    var error: Error?

    /// A response the mock session should return when executing the request.
    var httpResponse: HTTPURLResponse?

    /**
     Executes a data request.
     - Parameters:
        - request: The request to be executed.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    func loadData(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable {
        // Simulate a time-consuming operation...
        let simulatedExecutionTime = getRandomExecutionTime()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + simulatedExecutionTime) {
            if let error = self.error {
                completion(nil, self.httpResponse, error)
            } else {
                guard let mockResponseFile = FileDescription.json(with: "sample_activity_details") else {
                    completion(nil, self.httpResponse, NetworkError.unknown)
                    return
                }
                let mockData = self.getSampleData(from: mockResponseFile, in: .module)
                completion(mockData, self.httpResponse, nil)
            }
        }
        return MockRequest()
    }

    // MARK: - Support

    private func getRandomExecutionTime() -> DispatchTimeInterval {
        let upperBound: UInt32 = 3
        let lowerBound: UInt32 = 1
        let randomExecutionTime = Int(arc4random_uniform(upperBound - lowerBound) + lowerBound)
        return DispatchTimeInterval.seconds(randomExecutionTime)
    }
}

class MockRequest: Cancellable {
    func cancel() { }
}

extension MockNetworkSession: TestDataSampling { }
#endif
