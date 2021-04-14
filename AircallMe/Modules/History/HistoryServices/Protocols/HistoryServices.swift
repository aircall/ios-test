//
//  HistoryServices.swift
//  HistoryServices
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation
import Common

/// Protocol to manage History data from an API or other
protocol HistoryServices {
    
    /// Method to retrieve the history list item
    /// - Parameter completion: The completion handler that return a Result type with an array of HistoryModel on success and a HTTPStatus error code on failure
    func loadHistoryList(completion: @escaping CompletionHandler<[HistoryModel]>)
    
    /// Method change the "archived" status to "true" for a history item
    /// - Parameters:
    ///   - identifier: the identifier of the history item
    ///   - completion: The completion handler that return a Result type without object on success and a HTTPStatus error code on failure
    func archiveHistoryEntry(identifier: Int, completion: @escaping CompletionHandler<Void>)
    
    /// Method change all "archived" status to "false" for all history item
    /// - Parameter completion: The completion handler that return a Result type without object on success and a HTTPStatus error code on failure
    func resetArchiveStatus(completion: @escaping CompletionHandler<Void>)
}
