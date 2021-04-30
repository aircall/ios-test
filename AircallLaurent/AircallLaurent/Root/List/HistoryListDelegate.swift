//
//  HistoryListDelegate.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import UIKit
import CoreData

final class HistoryListDelegate: NSObject, UITableViewDelegate {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  private let provider: NSFetchedResultsController<Call>

  /******************** Callbacks ********************/

  var didSelect: ((CallModel) -> Void)?

  var didTapDetail: ((CallModel) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with provider: NSFetchedResultsController<Call>) {
    self.provider = provider
  }

  //----------------------------------------------------------------------------
  // MARK: - Delegate
  //----------------------------------------------------------------------------

  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    let callModel = provider.object(at: indexPath).callModel
    didSelect?(callModel)
  }

  func tableView(_ tableView: UITableView,
                 accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let callModel = provider.object(at: indexPath).callModel
    didTapDetail?(callModel)
  }

  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.bounds.height / 10
  }

}
