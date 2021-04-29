//
//  HistoryListDataProvider.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

final class HistoryListDataProvider: CollectionDataProvider {

  //----------------------------------------------------------------------------
  // MARK: - Typealias
  //----------------------------------------------------------------------------

  typealias CallCellConfigurator = CellConfigurator
  <
    GenericTableViewCell,
    GenericTableViewCellViewModelProtocol
  >

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  var items = [[CellConfigurating]]() {
    didSet {
      if items.isEmpty {
        dataDidClear?()
      } else {
        let flatItems = items.flatMap { $0 }
        shouldRegisterCells?(flatItems)
        dataDidChange?()
      }
    }
  }

  /******************** Text ********************/

  private var callDuration: String?

  private var callInformationTitle: String {
    var callDurationText = ""
    if let callDuration = callDuration {
      callDurationText = " (\(callDuration)sec)"
    }
    return "Call information\(callDurationText)"
  }

  /******************** Callbacks ********************/

  /// Items in table view data provider did change
  var dataDidChange: (() -> Void)?

  var shouldRegisterCells: (([CellConfigurating]) -> Void)?

  /// Items in table view data provider did clear
  var dataDidClear: (() -> Void)?

  var didSelect: ((CallModel) -> Void)?

  var didSelectAccessory: ((CallModel) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // MARK: - TableView
  //----------------------------------------------------------------------------

  func update(with calls: [CallModel]) {
    let nonArchivedCalls = calls.filter { $0.isArchived == false }

    let newItems = nonArchivedCalls.map { call -> CallCellConfigurator in
      let callCellViewModel = CallTableViewCellViewModel(with: call)
      let callCellConfigurator = CallCellConfigurator(data: callCellViewModel)

      callCellConfigurator.didSelect = { [weak self] call in
        self?.didSelect?(call.call)
      }

      callCellConfigurator.didSelectAccessory = { [weak self] call in
        self?.didSelectAccessory?(call.call)
      }

      return callCellConfigurator
    }

    items = [newItems]
  }

}
