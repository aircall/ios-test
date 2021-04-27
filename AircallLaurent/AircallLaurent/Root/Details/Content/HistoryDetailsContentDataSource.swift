//
//  HistoryDetailsContentDataSource.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

final class HistoryDetailsContentDataSource: NSObject, UITableViewDataSource
{

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let provider: HistoryDetailsContentDataProvider

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with provider: HistoryDetailsContentDataProvider) {
    self.provider = provider
  }

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  func tableView(_ tableView: UITableView,
                 titleForHeaderInSection section: Int) -> String? {
    return provider.headerTitles[section]
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return provider.numberOfSections()
  }

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return provider.numberOfItems(in: section)
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let item = provider.item(at: indexPath) else {
      return UITableViewCell()
    }
    return item.configuratedCellFor(tableView: tableView,
                                    atIndexPath: indexPath)
  }

}
