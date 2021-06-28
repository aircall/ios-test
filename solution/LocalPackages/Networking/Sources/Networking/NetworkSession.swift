//
//  NetworkSession.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import Foundation

/**
 Defines a network session in which the requests are executed.
 */
public protocol NetworkSession {
    /**
     Executes a data request.
     - Parameters:
        - request: The request to be executed.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    func loadData(from request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable
}
