//
//  HistoryServicesImpl.swift
//  HistoryServices
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit
import Common
import Networking

/// Implementation for the HistoryServices protocol - provide methods to manage history data with the API or a cache manager (if it exists)
final class HistoryServicesImpl: HistoryServices {
    
    /// Request manager
    private let reqManager: APIRequest
    
    /// Init the services with an object conform to the APIRequest protocol
    /// - Parameter manager: request manager
    init(manager: APIRequest) {
        reqManager = manager
    }
   
    /// Method to retrieve the history list item
    /// - Parameter completion: The completion handler that return a Result type with an array of HistoryModel on success and a HTTPStatus error code on failure
    func loadHistoryList(completion: @escaping CompletionHandler<[HistoryModel]>) {
        
        reqManager.sendRequest(requestFactory: HistoryUrlFactory.list) {data, statusCode in

            //Specific case -> no status code, return a generic error code
            guard let statusCode = statusCode else {
                completion(.failure(.serviceUnavailable))
                return
            }
            
            //If no data return a failure with the status code
            guard let data = data else {
                completion(.failure(statusCode))
                return
            }

            switch statusCode.responseType {
            case .success:
                do {
                    // Decode data by using JSONDecoder
                    let list = try [HistoryModel].decode(data: data)
                    completion(.success(list))
                } catch {
                    // Error case : the json data does not fit with the codable declaration
                    print(error.localizedDescription)
                    completion(.failure(.serviceUnavailable))
                }
            default:
                completion(.failure(statusCode))
            }
        }
    }
    
    /// Method change the "archived" status to "true" for a history item
    /// - Parameters:
    ///   - identifier: the identifier of the history item
    ///   - completion: The completion handler that return a Result type without object on success and a HTTPStatus error code on failure
    func archiveHistoryEntry(identifier: Int, completion: @escaping CompletionHandler<Void>) {
        
        reqManager.sendRequest(requestFactory: HistoryUrlFactory.archive(identifier: identifier)) {
            completion(HistoryServicesImpl.defaultResponse(statusCode: $1))
        }
    }
    
    /// Method change all "archived" status to "false" for all history item
    /// - Parameter completion: The completion handler that return a Result type without object on success and a HTTPStatus error code on failure
    func resetArchiveStatus(completion: @escaping CompletionHandler<Void>) {
        
        reqManager.sendRequest(requestFactory: HistoryUrlFactory.reset) {
            completion(HistoryServicesImpl.defaultResponse(statusCode: $1))
        }
    }
    
    /// Helper method to manage simple result of an api request (response without data, just the status code)
    /// - Parameter statusCode: the status code response of the request
    /// - Returns: The Result object -> success(void) on success and failure(statusCode) if status code is an error
    private static func defaultResponse(statusCode: HTTPStatusCode?) -> Result<Void, HTTPStatusCode> {
        
        //Specific case -> no status code, return a generic error code
        guard let statusCode = statusCode else {
            return .failure(.serviceUnavailable)
        }
        
        switch statusCode.responseType {
        case .success:
            return .success(())
        default:
            return .failure(statusCode)
        }
    }
    
}
