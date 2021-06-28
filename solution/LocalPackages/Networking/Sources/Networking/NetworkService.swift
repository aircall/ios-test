//
//  NetworkService.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import Foundation

/**
 Defines a network service responsible for the communications between client and server.
 */
public protocol NetworkService {
    /**
     Executes a request to a given endpoint
     - Parameters:
        - endpoint: The endpoint to send the request to.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    func request(endpoint: Requestable, completion: @escaping (Result<Data?, NetworkError>) -> Void) -> Cancellable?
}
