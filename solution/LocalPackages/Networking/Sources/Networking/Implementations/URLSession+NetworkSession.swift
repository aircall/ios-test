//
//  URLSession+NetworkSession.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import Foundation

extension URLSessionTask: Cancellable { }

extension URLSession: NetworkSession {

    /**
     Executes a data request.
     - Parameters:
        - request: The request to be executed.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    public func loadData(
        from request: URLRequest,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> Cancellable {
        let task = dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
        return task
    }
}
