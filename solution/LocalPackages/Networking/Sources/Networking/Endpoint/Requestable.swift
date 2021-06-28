//
//  Requestable.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 Defines a type which can be request via an HTTP API.
 */
public protocol Requestable {
    /// The path to the requestable resource.
    var path: String { get }
    /// The HTTP method.
    var method: HTTPMethod { get }
    /// The request body data.
    var body: Data? { get }

    /**
     Creates an instance of `URLRequest` for the instance with the given configuration.
     - Parameters: A network configuration (`NetworkConfigurable`).
     - Returns: An instance of `URLRequest`.
     */
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}
