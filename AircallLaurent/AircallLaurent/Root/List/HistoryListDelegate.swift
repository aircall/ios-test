//
//  HistoryListDelegate.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import UIKit

final class HistoryListDelegate: NSObject, UITableViewDelegate {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  private let provider: HistoryListDataProvider

  /******************** Callbacks ********************/

  var didTapDetail: ((CallModel) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with provider: HistoryListDataProvider) {
    self.provider = provider
  }

  //----------------------------------------------------------------------------
  // MARK: - Delegate
  //----------------------------------------------------------------------------

  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    provider.item(at: indexPath)?.select()
  }

  func tableView(_ tableView: UITableView,
                 accessoryButtonTappedForRowWith indexPath: IndexPath) {
    provider.item(at: indexPath)?.tapAccessoryButton()

  }

  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.bounds.height / 10
  }

}
