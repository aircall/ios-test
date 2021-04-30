//
//  HistoryDetailsInformationDelegate.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

/*******************************************************************************
 * HistoryDetailsInformationDelegate
 *
 * A delegate for the HistoryDetails tableview
 *
 ******************************************************************************/

final class HistoryDetailsInformationDelegate: NSObject, UITableViewDelegate {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  private let provider: HistoryDetailsInformationDataProvider

  /******************** Callbacks ********************/

  var didTapDetail: ((CallModel) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with provider: HistoryDetailsInformationDataProvider) {
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

  func tableView(_ tableView: UITableView,
                 heightForHeaderInSection section: Int) -> CGFloat {
    return tableView.bounds.height / 5
  }

}
