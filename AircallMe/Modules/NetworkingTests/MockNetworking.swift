//
//  MockNetworking.swift
//  NetworkingTests
//
//  Created by Rudy Frémont on 14/04/2021.
//

import Foundation
@testable import Networking

/// Mock class for UrlFactory protocol
struct MockUrlFactory: UrlFactory {
    
    func url() -> URL {
        return URL(string: "http://google.com")!
    }
    
    func method() -> RestMethod {
        return .get
    }
    
    func body() -> Data? {
        return nil
    }
}

/// We create a partial mock by subclassing the original class
class URLSessionDataTaskMock: URLSessionDataTask {
    override init() {}
    override func resume() {}
}

/// Mock class for URLSessionProtocol protocol
class MockURLSession: URLSessionProtocol {

    var nextDataTask = URLSessionDataTaskMock()
    var nextData: Data?
    var nextError: Error?
    var nextStatusCode: Int = 200
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(nil, getHTTPURLResponse(request: request), nextError)
        return nextDataTask
    }
    
    func getHTTPURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: nextStatusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
}

/// Mock class for Error protocol
enum MockError: Swift.Error, Equatable {
    case error
}
