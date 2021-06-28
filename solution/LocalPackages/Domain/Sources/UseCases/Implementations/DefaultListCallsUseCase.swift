//
//  DefaultListCallsUseCase.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Combine
import Foundation

/**
 The default implementation for the use case for listing calls.
 */
public class DefaultListCallsUseCase: ListCallsUseCase {

    private let repository: CallsRepository

    /**
     Creates an instance of `DefaultListCallsUseCase` with the given parameters.
     - Parameters:
        - callsRepository: A repository to coordinating all data related to calls.
     - Returns: An instance of `DefaultListCallsUseCase`
     */
    public init(callsRepository: CallsRepository) {
        repository = callsRepository
    }

    /**
     List all unarchived calls.
     - Parameters:
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    @discardableResult
    public func execute(completion: @escaping (Result<[Call], Error>) -> Void) -> Cancellable? {
        repository.list { result in
            switch result {
            case let .success(calls):
                let notArchivedCalls = calls.filter { !$0.isArchived }
                completion(.success(notArchivedCalls))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
