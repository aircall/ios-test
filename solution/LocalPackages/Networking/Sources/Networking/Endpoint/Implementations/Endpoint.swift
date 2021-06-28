//
//  Endpoint.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 Stores information about an endpoint that can be requested via HTTP.
 */
public class Endpoint: Requestable {
    /// The relative path to the endpoint.
    public var path: String
    /// The HTTP method.
    public var method: HTTPMethod = .get
    /// The request body data.
    public var body: Data?

    /**
     Creates an instance of `Endpoint` with the given parameters.
     - Parameters:
        - path: The relative path to the endpoint.
        - method: The HTTP method.
        - body: The request body data.
     - Returns: An instance of `Endpoint`
     */
    public init(path: String,
                method: HTTPMethod = .get,
                body: Data? = nil) {
        self.path = path
        self.method = method
        self.body = body
    }
}
