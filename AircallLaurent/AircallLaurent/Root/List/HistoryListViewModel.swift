//
//  HistoryListViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

final class HistoryListViewModel {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  let dataProvider: HistoryListDataProvider

  /******************** Callbacks ********************/

  var didFail: ((Error) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with dataProvider: HistoryListDataProvider = HistoryListDataProvider()) {
    self.dataProvider = dataProvider
  }

  //----------------------------------------------------------------------------
  // MARK: - Network
  //----------------------------------------------------------------------------

  func fetchCalls() { //completion: ((Result<[CallModel], Error>)-> Void)) {
    let calls = [
      CallModel(id: 31,
                createdAt: "2018-04-19T09:38:41.000Z",
                direction: .outbound,
                sender: "Pierre-Baptiste Béchu",
                receiver: "06 46 62 12 33",
                phoneOperator: "NYC Office",
                duration: "120",
                isArchived: false,
                callType: .missed),
      CallModel(id: 31,
                createdAt: "2018-04-19T09:38:41.000Z",
                direction: .outbound,
                sender: "Pierre-Baptiste Béchu",
                receiver: "06 46 62 12 33",
                phoneOperator: "NYC Office",
                duration: "120",
                isArchived: false,
                callType: .missed),
      CallModel(id: 31,
                createdAt: "2018-04-19T09:38:41.000Z",
                direction: .outbound,
                sender: "Pierre-Baptiste Béchu",
                receiver: "06 46 62 12 33",
                phoneOperator: "NYC Office",
                duration: "120",
                isArchived: false,
                callType: .missed),
      CallModel(id: 31,
                createdAt: "2018-04-19T09:38:41.000Z",
                direction: .outbound,
                sender: "Pierre-Baptiste Béchu",
                receiver: "06 46 62 12 33",
                phoneOperator: "NYC Office",
                duration: "120",
                isArchived: false,
                callType: .missed),
      CallModel(id: 31,
                createdAt: "2018-04-19T09:38:41.000Z",
                direction: .outbound,
                sender: "Pierre-Baptiste Béchu",
                receiver: "06 46 62 12 33",
                phoneOperator: "NYC Office",
                duration: "120",
                isArchived: false,
                callType: .missed)
    ]
//    completion(.success(calls))
    dataProvider.update(with: calls)
  }

}
