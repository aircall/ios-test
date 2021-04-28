//
//  AircallAPI.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

class AircallAPI {

  //----------------------------------------------------------------------------
  // MARK: - Typealias
  //----------------------------------------------------------------------------

  /// Basic default completion for an api call
  typealias APICompletion<T> = (Result<T, Error>) -> Void

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  public static let shared = AircallAPI()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private init() {}

  //----------------------------------------------------------------------------
  // MARK: - Queue
  //----------------------------------------------------------------------------

  private func addOperationToNetworkQueue(_ operation: Operation?) {
    guard let operation = operation else { return }
    NetworkQueue.shared.addOperation(operation: operation)
  }

  //----------------------------------------------------------------------------
  // MARK: - API calls
  //----------------------------------------------------------------------------


  /******************** Reset ********************/

  private var resetOperation: GetResetOperation?

  func reset(completion: @escaping APICompletion<ResetModel>) {
    resetOperation = GetResetOperation()
    resetOperation?.completionBlockInMainThread = completion
    addOperationToNetworkQueue(resetOperation)
  }

  /******************** Calls ********************/

  private var getCallsOperation: GetCallsOperation?

  func getCalls(completion: @escaping APICompletion<[CallModel]>) {
    getCallsOperation = GetCallsOperation()
    getCallsOperation?.completionBlockInMainThread = completion
    addOperationToNetworkQueue(getCallsOperation)
  }

  /******************** Call ********************/

  private var getCallOperation: GetCallOperation?

  func getCall(withId id: Int, completion: @escaping APICompletion<CallModel>) {
    getCallOperation = GetCallOperation(id: id)
    getCallOperation?.completionBlockInMainThread = completion
    addOperationToNetworkQueue(getCallOperation)
  }

  /******************** Call ********************/

  private var postCallOperation: PostCallOperation?

  func postCall(_ call: CallModel,
                completion: @escaping APICompletion<CallModel>) {
    postCallOperation = PostCallOperation(call: call)
    postCallOperation?.completionBlockInMainThread = completion
    addOperationToNetworkQueue(postCallOperation)
  }

}
