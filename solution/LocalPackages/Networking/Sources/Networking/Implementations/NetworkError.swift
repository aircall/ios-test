//
//  NetworkError.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 Described the types of errors when executing a request with the `DefaultNetworkService`.
 */
public enum NetworkError: Error {
    /// An HTTP error occurred with the given status code.
    case errorStatusCode(_ statusCode: Int)
    /// The device is not connected to the Internet.
    case notConnected
    /// The request was cancelled.
    case cancelled
    /// Failed to generate the URL for the request.
    case urlGeneration
    /// An underlying error occurred.
    case underlyingError(_ error: Error)
    /// An unexpected error occurred.
    case unknown
}
