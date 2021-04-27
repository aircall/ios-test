//
//  HistoryDetailsInformationDelegate.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

final class HistoryDetailsInformationDelegate: NSObject, UITableViewDelegate {

  var provider: HistoryDetailsInformationDataProvider

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
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.bounds.height / 5
  }

  func tableView(_ tableView: UITableView,
                 heightForHeaderInSection section: Int) -> CGFloat {
    return tableView.bounds.height / 5
  }

//  func tableView(_ tableView: UITableView,
//                          viewForHeaderInSection section: Int) -> UIView? {
//    let view = UIView()
//    let label = UILabel()
//    label.text = provider.headerTitles[section]
//    view.add(subview: label, with: .center())
//    view.backgroundColor = .white
//    return view
//  }

}
