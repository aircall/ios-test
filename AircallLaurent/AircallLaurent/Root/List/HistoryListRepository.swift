//
//  HistoryListRepository.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import UIKit
import CoreData

final class HistoryListRepository {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Providers ********************/

  private let apiClient: AircallAPI

  private var database: Database

  /******************** Callbacks ********************/

  var didFail: ((Error) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(apiClient: AircallAPI = .shared, database: Database = .shared) {
    self.apiClient = apiClient
    self.database = database
  }

  //----------------------------------------------------------------------------
  // MARK: - Calls
  //----------------------------------------------------------------------------

  func fetchCalls(completion: @escaping ResultCompletion<[CallModel]>) {
    apiClient.getCalls { [weak self] result in
      switch result {
        case .success(let calls):
          let url = self?.database.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url
          print(url)
          self?.database.persistentContainer.performBackgroundTask { context in
            for call in calls {
              if self?.database.findCall(id: call.id,
                                         inContext: context) == nil {
                let dbCall = Call(context: context)
                dbCall.configure(from: call)
              }

            }
            try? context.save()
            DispatchQueue.main.async {
              completion(.success(calls))
            }
          }

        case .failure(let error):
          completion(.failure(error))
      }
    }
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
