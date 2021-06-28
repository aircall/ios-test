//
//  DefaultCallsRepository.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import Domain
import Foundation
import Networking

/**
 The default implementation of `CallsRepository`. A repository responsible for coordinating the data from different data sources for the calls.
 */
public class DefaultCallsRepository: CallsRepository {

    private let dataTransferService: DataTransfer

    /**
     Creates an instance of `DefaultCallsRepository` with the given parameters.
     - Parameters:
        - dataTransferService: An instance of a `DataTransfer` service.
     - Returns: An instance of `DefaultCallsRepository`
     */
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }

    /**
     Lists all calls.
     - Parameters:
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    public func list(with result: @escaping (Result<[Call], Error>) -> Void) -> Cancellable? {
        dataTransferService.request(with: APIEndpoints.calls()) { response in
            switch response {
            case let .success(calls):
                result(.success(calls.compactMap(Call.map)))
            case let .failure(error):
                result(.failure(error))
            }
        }
    }

    /**
     Archives a call.
     - Parameters:
        - callId: The id of the call.
        - archive: Tells whether the call should be archived or not.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    public func archiveCall(with callId: UInt, archive: Bool, completion: @escaping (Result<Call, Error>) -> Void) -> Cancellable? {
        let endpoint = APIEndpoints.archiveCall(with: callId, archive: archive)
        return dataTransferService.request(with: endpoint) { response in
            switch response {
            case let .success(callResponse):
                guard let call = Call.map(callResponse) else {
                    completion(.failure(RepositoryError.failedEntityMapping))
                    return
                }
                completion(.success(call))
                NotificationCenter.default.post(name: .callUpdated, object: call)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
