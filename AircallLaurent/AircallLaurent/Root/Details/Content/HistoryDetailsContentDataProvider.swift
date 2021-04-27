//
//  HistoryDetailsContentDataProvider.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

class HistoryDetailsContentDataProvider: CollectionDataProvider {

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
    guard let callDuration = callDuration else { return "" }
    return "Call information (\(callDuration)sec)"
  }

  /******************** Callbacks ********************/

  /// Items in table view data provider did change
  var dataDidChange: (() -> Void)?

  /// Items in table view data provider did clear
  var dataDidClear: (() -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  //--------------------------------------------------------------------------
  // MARK: - TableView
  //--------------------------------------------------------------------------

  func registerOn(_ tableView: UITableView) {
    for cellConfiguratorSections in items {
      for cellConfigurator in cellConfiguratorSections {
        cellConfigurator.register(on: tableView)
      }
    }
  }

  func update(with call: CallModel) {
//    updateContactInformation()
//    updateCallInformation()
    var informationItems = [[CellConfigurating]]()

    let contactCellViewModel = ContactInformationTableViewCellViewModel(with: call)
    let contactCellConfigurator = InformationCellConfigurator(data: contactCellViewModel)
    let contactInformationItems = [contactCellConfigurator]

    let directionCellViewModel = CallInformationDirectionTableViewCellViewModel(with: call)
    let diractionCellConfigurator = InformationCellConfigurator(data: directionCellViewModel)

    let phoneOperatorViewModel = CallInformationPhoneOperatorTableViewCellViewModel(with: call)
    let phoneOperatorCellConfigurator = InformationCellConfigurator(data: phoneOperatorViewModel)
    let callInformationItems: [CellConfigurating] =
      [diractionCellConfigurator, phoneOperatorCellConfigurator]

    informationItems.append(contactInformationItems)
    informationItems.append(callInformationItems)

    items = informationItems
  }

  private func updateContactInformation() {

  }

  private func updateCallInformation() {

  }

}
