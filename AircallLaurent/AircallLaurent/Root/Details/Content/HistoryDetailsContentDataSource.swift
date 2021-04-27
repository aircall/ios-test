//
//  HistoryDetailsContentDataSource.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

class HistoryDetailsContentDataSource:
  TableViewDataSource<HistoryDetailsContentDataProvider>
{

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  func tableView(_ tableView: UITableView,
                 titleForHeaderInSection section: Int) -> String? {
    return provider.headerTitles[section]
  }

}
