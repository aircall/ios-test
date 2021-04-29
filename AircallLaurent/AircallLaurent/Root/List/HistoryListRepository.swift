//
//  HistoryListRepository.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

final class HistoryListRepository {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Providers ********************/

  private let apiClient: AircallAPI

//  private let database:

  /******************** Callbacks ********************/

  var didFail: ((Error) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(apiClient: AircallAPI = .shared) {
    self.apiClient = apiClient
  }

  //----------------------------------------------------------------------------
  // MARK: - Calls
  //----------------------------------------------------------------------------

  func fetchCalls(completion: @escaping ResultCompletion<[CallModel]>) {
    apiClient.getCalls(completion: completion)
  }

  func fetchCall(id: Int, completion: @escaping ResultCompletion<CallModel>) {
    apiClient.getCall(withId: id, completion: completion)
  }

  func reset(completion: @escaping ResultCompletion<ResetModel>) {
    apiClient.reset(completion: completion)
  }

  func update(call: CallModel,
              completion: @escaping ResultCompletion<CallModel>) {
    apiClient.postCall(call, completion: completion)
  }

}
