//
//  DefaultDataTransferService.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import Common
import Foundation

/**
 The default implementation of the `DataTransfer`. A service for requesting data over the network.
 */
public class DefaultDataTransferService: DataTransfer {

    private let networkService: NetworkService

    /**
     Creates an instance of `DefaultDataTransferService` with the given parameters.
     - Parameters:
        - networkService: An instance of `NetworkService`.
     - Returns: An instance of `DefaultDataTransferService`
     */
    public init(with networkService: NetworkService) {
        self.networkService = networkService
    }

    /**
     Executes a request with the given parameters.
     - Parameters:
        - endpoint: A generic `DataEndpoint` which expects a specific type.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    public func request<T>(
        with endpoint: DataEndpoint<T>,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Cancellable? where T: Decodable {
        request(with: endpoint, respondOnQueue: .main, completion: completion)
    }

    /**
     Executes a request with the given parameters.
     - Parameters:
        - endpoint: A `DataEndpoint` which expects some `Data` in the response.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    public func request(
        with endpoint: DataEndpoint<Data>,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable? {
        request(with: endpoint, respondOnQueue: .main, completion: completion)
    }

    /**
     Executes a request with the given parameters.
     - Parameters:
        - endpoint: A generic `DataEndpoint`.
        - respondOnQueue: The `DispatchQueue` in which the response should be dispatched.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    public func request<T: Decodable>(
        with endpoint: DataEndpoint<T>,
        respondOnQueue: DispatchQueue,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Cancellable? {
        networkService.request(endpoint: endpoint) { result in
            switch result {
            case let .success(data):
                guard let data = data else {
                    respondOnQueue.async { completion(Result.failure(DataTransferError.noResponse)) }
                    return
                }
                do {
                    let decoder = JSONDecoder.withFullISO8601Strategy
                    let result = try decoder.decode(T.self, from: data)
                    respondOnQueue.async { completion(.success(result)) }
                } catch {
                    respondOnQueue.async { completion(Result.failure(DataTransferError.parsingJSON)) }
                }
            case .failure(let error):
                respondOnQueue.async { completion(Result.failure(DataTransferError.networkFailure(error))) }
            }
        }
    }

    /**
     Executes a request with the given parameters.
     - Parameters:
        - endpoint: A `DataEndpoint` which expects some `Data` in the response.
        - respondOnQueue: The `DispatchQueue` in which the response should be dispatched.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    public func request(
        with endpoint: DataEndpoint<Data>,
        respondOnQueue: DispatchQueue,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable? {
        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                guard let data = data
                else {
                    respondOnQueue.async { completion(Result.failure(DataTransferError.noResponse)) }
                    return
                }
                respondOnQueue.async { completion(Result.success(data)) }
            case .failure(let error):
                respondOnQueue.async { completion(Result.failure(DataTransferError.networkFailure(error))) }
            }
        }
    }
}
