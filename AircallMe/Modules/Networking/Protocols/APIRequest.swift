//
//  APIRequest.swift
//  Networking
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation
import Common

/// Protocol for simple api request
public protocol APIRequest: class {
    
    /// Send a request
    /// - Parameters:
    ///   - requestFactory: The url request factory
    ///   - completion: The request completion handler with the data and/or the status code of the request
    func sendRequest(requestFactory: UrlFactory, completion: @escaping (Data?, HTTPStatusCode?) -> Void)
    
    /// Cancel the current request
    func cancelRequests()
}
