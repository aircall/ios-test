//
//  RequestError.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 Described the types of errors when executing a request.
 */
enum RequestError: Error {
    /// Occurs when there's a failure creating a request.
    case failedRequestCreation
}
