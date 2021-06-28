//
//  DefaultArchivingCallUseCase.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Combine
import Foundation

/**
 The default implementation for the use case for archiving a call.
 */
public class DefaultArchivingCallUseCase: ArchivingCallUseCase {

    private let repository: CallsRepository

    /**
     Creates an instance of `DefaultArchivingCallUseCase` with the given parameters.
     - Parameters:
        - callsRepository: A repository to coordinating all data related to calls.
     - Returns: An instance of `DefaultArchivingCallUseCase`
     */
    public init(callsRepository: CallsRepository) {
        repository = callsRepository
    }

    /**
     Archives a call.
     - Parameters:
        - callId: The id of the call to archive or unarchive.
        - archive: Tells whether the call with the given id should be archived or unarchived.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    @discardableResult
    public func archiveCall(with callId: UInt, archive: Bool, completion: @escaping (Result<Call, Error>) -> Void) -> Cancellable? {
        repository.archiveCall(with: callId, archive: archive, completion: completion)
    }
}
