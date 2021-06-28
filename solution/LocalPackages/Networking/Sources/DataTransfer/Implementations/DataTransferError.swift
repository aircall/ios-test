//
//  File.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 Described the types of errors when executing a request with the `DefaultDataTransferService`.
 */
public enum DataTransferError: Error {
    /// No response data in a request expecting data.
    case noResponse
    /// Error parsing the JSON response.
    case parsingJSON
    /// A network failure occurred.
    case networkFailure(_ networkError: NetworkError)
}
