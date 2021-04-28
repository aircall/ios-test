//
//  HistoryListDataSource.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import UIKit

final class HistoryListDataSource: NSObject, UITableViewDataSource
{

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let provider: HistoryListDataProvider

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with provider: HistoryListDataProvider) {
    self.provider = provider
  }

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

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
