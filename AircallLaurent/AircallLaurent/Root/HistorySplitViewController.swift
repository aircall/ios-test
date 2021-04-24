//
//  HistorySplitViewController.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.
//

import UIKit

class HistorySplitViewController: UISplitViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------


  /******************** ViewControllers ********************/

  private lazy var historyListViewController: HistoryListViewController = {
    return HistoryListViewController()
  }()

  private lazy var historyDetailsViewController: HistoryDetailsViewController =
    {
      return HistoryDetailsViewController()
  }()

  //----------------------------------------------------------------------------
  // MARK: - Lifecycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private func setup() {
      setupSplitViewController()
      setupViewControllers()
    }

    private func setupSplitViewController() {
      preferredDisplayMode = .allVisible
      delegate = self
    }

    private func setupViewControllers() {
      setupMasterViewController()
      setupDetailViewController()
    }

    private func setupMasterViewController() {
      historyListViewController.didSelectCall = { [weak self] id in
        print(id)
      }
    }

    private func setupDetailViewController() {
    }

}

//==============================================================================
// MARK: - UISplitViewControllerDelegate
//==============================================================================

extension HistorySplitViewController: UISplitViewControllerDelegate {

  func splitViewController(_ splitViewController: UISplitViewController,
  collapseSecondary secondaryViewController: UIViewController,
  onto primaryViewController: UIViewController) -> Bool {
    return true
  }

}
