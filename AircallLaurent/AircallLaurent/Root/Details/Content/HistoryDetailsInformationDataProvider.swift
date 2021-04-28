//
//  HistoryDetailsInformationDataProvider.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

class HistoryDetailsInformationDataProvider: CollectionDataProvider {

  //----------------------------------------------------------------------------
  // MARK: - Typealias
  //----------------------------------------------------------------------------

  typealias InformationCellConfigurator = CellConfigurator
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

  var headerTitles: [String] {
    return ["Contact information", callInformationTitle]
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

//  func registerOn(_ tableView: UITableView) {
//    for cellConfiguratorSections in items {
//      for cellConfigurator in cellConfiguratorSections {
//        cellConfigurator.register(on: tableView)
//      }
//    }
//  }

  func update(with call: CallModel) {
    let contactInformationItems = generateContactInformationCells(from: call)
    let callInformationItems = generateCallInformationCells(from: call)

    let newItems = [contactInformationItems, callInformationItems]

    for item in newItems.flatMap({ $0 }) {
      item.didSelect = { [weak self] cellViewModel in
        self?.didSelect?(cellViewModel.call)
      }

      item.didSelectAccessory = { [weak self] cellViewModel in
        self?.didSelectAcessory?(cellViewModel.call)
      }
    }

    items = [contactInformationItems, callInformationItems]
  }

  private func generateContactInformationCells(
    from call: CallModel
  ) -> [InformationCellConfigurator] {
    let contactCellViewModel =
      ContactInformationTableViewCellViewModel(with: call)
    let contactCellConfigurator =
      InformationCellConfigurator(data: contactCellViewModel)
    return [contactCellConfigurator]
  }

  private func generateCallInformationCells(
    from call: CallModel
  ) -> [InformationCellConfigurator] {
    let directionCellViewModel =
      CallInformationDirectionTableViewCellViewModel(with: call)
    let diractionCellConfigurator =
      InformationCellConfigurator(data: directionCellViewModel)

    let phoneOperatorViewModel =
      CallInformationPhoneOperatorTableViewCellViewModel(with: call)
    let phoneOperatorCellConfigurator =
      InformationCellConfigurator(data: phoneOperatorViewModel)
    return [diractionCellConfigurator, phoneOperatorCellConfigurator]
  }

}
