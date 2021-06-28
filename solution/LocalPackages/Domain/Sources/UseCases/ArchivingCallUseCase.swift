//
//  ArchivingCallUseCase.swift
//  
//
//  Created by Jobert on 26/06/2021.
//

import Combine
import Common
import Foundation

/**
 Defines the use case for archiving and unarchving a call.
 */
public protocol ArchivingCallUseCase {
    /**
     Archives a call.
     - Parameters:
        - callId: The id of the call to archive or unarchive.
        - archive: Tells whether the call with the given id should be archived or unarchived.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    func archiveCall(with callId: UInt, archive: Bool, completion: @escaping (Result<Call, Error>) -> Void) -> Cancellable?
}
