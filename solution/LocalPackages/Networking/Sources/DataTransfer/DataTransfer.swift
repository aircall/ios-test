//
//  DataTransfer.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import Foundation

/**
 Defines a service for requesting data over the network.
 */
public protocol DataTransfer {
    /**
     Executes a request with the given parameters.
     - Parameters:
        - endpoint: A generic `DataEndpoint` which expects a specific type.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    @discardableResult
    func request<T: Decodable>(
        with endpoint: DataEndpoint<T>,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Cancellable?

    /**
     Executes a request with the given parameters.
     - Parameters:
        - endpoint: A `DataEndpoint` which expects some `Data` in the response.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    @discardableResult
    func request(
        with endpoint: DataEndpoint<Data>,
        completion: @escaping (Result<Data, Error>) -> Void)
    -> Cancellable?

    /**
     Executes a request with the given parameters.
     - Parameters:
        - endpoint: A generic `DataEndpoint`.
        - respondOnQueue: The `DispatchQueue` in which the response should be dispatched.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    @discardableResult
    func request<T: Decodable>(
        with endpoint: DataEndpoint<T>,
        respondOnQueue: DispatchQueue,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Cancellable?

    /**
     Executes a request with the given parameters.
     - Parameters:
        - endpoint: A `DataEndpoint` which expects some `Data` in the response.
        - respondOnQueue: The `DispatchQueue` in which the response should be dispatched.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    @discardableResult
    func request(with endpoint: DataEndpoint<Data>,
                 respondOnQueue: DispatchQueue,
                 completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable?
}
