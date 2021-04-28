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

  var didSelectAcessory: ((CallModel) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // MARK: - TableView
  //----------------------------------------------------------------------------

  func update(with calls: [CallModel]) {
    let newItems = calls.map { call -> CallCellConfigurator in
      let callCellViewModel = CallTableViewCellViewModel(with: call)
      let callCellConfiurator = CallCellConfigurator(data: callCellViewModel)

      return callCellConfiurator
    }

    items = [newItems]
  }

//  private func generateContactInformationCells(
//    from call: CallModel
//  ) -> [InformationCellConfigurator] {
//    let contactCellViewModel =
//      ContactInformationTableViewCellViewModel(with: call)
//    let contactCellConfigurator =
//      InformationCellConfigurator(data: contactCellViewModel)
//    return [contactCellConfigurator]
//  }
//
//  private func generateCallInformationCells(
//    from call: CallModel
//  ) -> [InformationCellConfigurator] {
//    let directionCellViewModel =
//      CallInformationDirectionTableViewCellViewModel(with: call)
//    let diractionCellConfigurator =
//      InformationCellConfigurator(data: directionCellViewModel)
//
//    let phoneOperatorViewModel =
//      CallInformationPhoneOperatorTableViewCellViewModel(with: call)
//    let phoneOperatorCellConfigurator =
//      InformationCellConfigurator(data: phoneOperatorViewModel)
//    return [diractionCellConfigurator, phoneOperatorCellConfigurator]
//  }
}
