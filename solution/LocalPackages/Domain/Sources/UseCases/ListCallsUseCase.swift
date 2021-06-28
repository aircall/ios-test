//
//  ListCallsUseCase.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Combine
import Common
import Foundation

/**
 Defines the use case for listing calls.
 */
public protocol ListCallsUseCase {
    /**
     List all calls.
     - Parameters:
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    func execute(completion: @escaping (Result<[Call], Error>) -> Void) -> Cancellable?
}
