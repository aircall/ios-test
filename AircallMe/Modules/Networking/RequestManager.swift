//
//  RequestManager.swift
//  Networking
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation
import Common

/// Define a protocol that fit with URLSession
protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

/// Make URLSession conform to the protocol.
extension URLSession: URLSessionProtocol {}

/// Implementation of the APIRequest protocol by using URLSessionProtocol
final class RequestManager: NSObject, APIRequest {

    internal var task: URLSessionTask?
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    /// Send a request
    /// - Parameters:
    ///   - requestFactory: The url request factory
    ///   - completion: The request completion handler with the data and/or the status code of the request
    func sendRequest(requestFactory: UrlFactory, completion: @escaping (Data?, HTTPStatusCode?) -> Void) {
        sendRequest(request: request(with: requestFactory), completion: completion)
    }
    
    /// Cancel the current request
    func cancelRequests() {
        task?.cancel()
    }
}

// MARK: - Private functions
extension RequestManager {
    
    /// Create the URL request with the url factory
    /// - Parameter factory: factory to use to build the request
    /// - Returns: created request
    private func request(with factory: UrlFactory) -> URLRequest {

        var components = URLComponents(url: factory.url(),
                                       resolvingAgainstBaseURL: false)
        components?.queryItems = factory.queryItems()
        guard let url = components?.url else { fatalError() }
        var request = URLRequest(url: url)
        request.httpMethod = factory.method().rawValue
        request.httpBody = factory.body()

        // We could add a method on UrlFactory to get specific HTTPHeaderField
        // Here we set only default one
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("no-cache", forHTTPHeaderField: "cache-control")
        
        return request
    }
    
    /// Send an URL request by using an implementation of URLSessionProtocol
    /// - Parameters:
    ///   - request: request to execute
    ///   - completion: The request completion handler with the data and/or the status code of the request
    private func sendRequest(request: URLRequest, completion: @escaping (Data?, HTTPStatusCode?) -> Void) {
        print("\(request)")
        task = session.dataTask(with: request) { data, response, error in
            
            //Return on the main queue
            DispatchQueue.main.async {
                if error != nil {
                    //General error
                    completion(nil, .serviceUnavailable)
                } else {
                    completion(data, response?.getStatusCode())
                }
            }
            
        }
        task?.resume()
    }
}
