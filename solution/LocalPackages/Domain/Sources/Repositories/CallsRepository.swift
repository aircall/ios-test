//
//  CallsRepository.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Combine
import Common
import Foundation

/**
 Defines a repository responsible for coordinating the data from different data sources for the calls.
 */
public protocol CallsRepository {
    /**
     Lists all calls.
     - Parameters:
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    @discardableResult
    func list(with completion: @escaping (Result<[Call], Error>) -> Void) -> Cancellable?

    /**
     Archives a call.
     - Parameters:
        - callId: The id of the call.
        - archive: Tells whether the call should be archived or not.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    @discardableResult
    func archiveCall(with callId: UInt, archive: Bool, completion: @escaping (Result<Call, Error>) -> Void) -> Cancellable?
}

public extension Notification.Name {
    /// Notificaion triggered after a `Call` in a `CallsRepository` gets updated.
    static let callUpdated = Notification.Name("callUpdated")
}
