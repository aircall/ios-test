//
//  ActivityListPresenter.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 27/06/2021.
//

import Foundation
import UIKit

protocol ActivityListPresenterProtocol {
  var source: UIViewController { get }

  func showActivityDetails(viewModel: ActivityViewModelProtocol, activity: Activity)
}

struct ActivityListPresenter: ActivityListPresenterProtocol {
  var source: UIViewController

  func showActivityDetails(viewModel: ActivityViewModelProtocol, activity: Activity) {
    let details = UIViewController.detailsViewController as! ActivityDetailViewController
    details.viewModel = viewModel
    details.activity = activity

    self.source.navigationController?.show(details, sender: self)
  }
}
