//
//  HistoryDetailsContentDataProvider.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

class HistoryDetailsContentDataProvider: CollectionDataProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  var items = [[CellConfigurating]]() {
      didSet {
        if items.isEmpty || items[0].isEmpty {
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

  private let callDuration: String

  private var callInformationTitle: String {
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

  init(with call: CallModel) {
    callDuration = call.duration
  }

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

}
