//
//  HistoryListRepository.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import UIKit
import CoreData

/*******************************************************************************
 * HistoryListRepository
 *
 * A repository for the history list with cache feature.
 *
 * /!\ In order to test this class we should
 * 1) Use protocol for `apiClient` and `database`
 * 2) Make `HistoryListRepository` conform to `HistoryListRepositoryProtocol`
 * 3) Mock all the functions from these protocols
 * 4) Be happy seeing the code coverage increasing :)
 * 
 ******************************************************************************/

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

  /******************** Calls ********************/

  func fetchCalls(completion: @escaping ResultCompletion<[CallModel]>) {
    apiClient.getCalls { [weak self] result in
      switch result {
        case .success(let calls):
          self?.saveCallsToDatabase(calls: calls) {
            completion(.success(calls))
          }

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  private func saveCallsToDatabase(calls: [CallModel],
                                   completion: (() -> Void)?) {
    database.persistentContainer.performBackgroundTask { context in
      for call in calls {
        if self.database.findCall(id: call.id, inContext: context) == nil {
          let dbCall = Call(context: context)
          dbCall.configure(from: call)
        }

      }
      try? context.save()
      DispatchQueue.main.async {
        completion?()
      }
    }
  }


  /******************** Call ********************/

  func fetchCall(id: Int, completion: @escaping ResultCompletion<CallModel>) {
    apiClient.getCall(withId: id, completion: completion)
  }


  /******************** Reset ********************/

  func reset(completion: @escaping ResultCompletion<Void>) {
    apiClient.reset { [weak self] result in
      switch result {
        case .failure(let error): completion(.failure(error))
        case .success(_): self?.handleResetSuccess { completion(.success(())) }
      }
    }
  }

  private func handleResetSuccess(completion: (() -> Void)?) {
    database.persistentContainer.performBackgroundTask { context in
      let fetchRequest: NSFetchRequest<Call> = Call.fetchRequest()
      guard let calls = try? context.fetch(fetchRequest) else {
        DispatchQueue.main.async {
          completion?()
        }
        return
      }

      for call in calls {
        call.isArchived = false
      }
      try? context.save()
      DispatchQueue.main.async {
        completion?()
      }
    }
  }

  /******************** Update ********************/

  func update(call: CallModel, completion: @escaping ResultCompletion<Void>) {
    apiClient.postCall(call) { [weak self] result in
      switch result {
        case .failure(let error):
          completion(.failure(error))
        case .success(let call):
          self?.handleUpdateSuccess(call: call) { completion(.success(()))}
      }
    }
  }

  private func handleUpdateSuccess(call: CallModel, completion: (() -> Void)?) {
    database.persistentContainer.performBackgroundTask { context in
      let callDb = self.database.findCall(id: call.id, inContext: context)
      callDb?.configure(from: call)
      try? context.save()
      DispatchQueue.main.async {
        completion?()
      }
    }
  }

}
