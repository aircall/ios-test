//
//  HistoryListDataSource.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import UIKit
import CoreData

/*******************************************************************************
 * HistoryListDataSource
 *
 * A data source used for the History list tableview
 *
 ******************************************************************************/

final class HistoryListDataSource: NSObject, UITableViewDataSource {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let provider: NSFetchedResultsController<Call>

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with provider: NSFetchedResultsController<Call>) {
    self.provider = provider
  }

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  func numberOfSections(in tableView: UITableView) -> Int {
    return provider.sections?.count ?? 0
  }

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    if let sections = provider.sections, section < sections.count {
      return sections[section].numberOfObjects
    } else {
      return 0
    }
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = GenericTableViewCell.reuseIdentifier
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
    ) as? GenericTableViewCell else {
      return UITableViewCell()
    }

    let callModel = provider.object(at: indexPath).callModel

    let cellViewModel = CallTableViewCellViewModel(with: callModel)
    cell.configure(with: cellViewModel)
    return cell
  }

}
