//
//  HistoryListDataProvider.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

/*******************************************************************************
 * HistoryListDataProvider
 *
 * A data provider for the list for the History list.
 *
 * /!\ NOT USED. For presentation purpose if we wouldn't have use
 * fetchedResultsController
 *
 ******************************************************************************/

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

  /******************** Callbacks ********************/

  /// Items in table view data provider did change
  var dataDidChange: (() -> Void)?

  /// Called when a table view should register the cells of the data provider.
  var shouldRegisterCells: (([CellConfigurating]) -> Void)?

  /// Items in table view data provider did clear
  var dataDidClear: (() -> Void)?

  /// Called when a cell is selected
  var didSelect: ((CallModel) -> Void)?


  /// Called when an accessory action of a cell is selected.
  var didSelectAccessory: ((CallModel) -> Void)?

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
