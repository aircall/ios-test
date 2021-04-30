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

  /******************** ViewModel ********************/

  private let viewModel: HistorySplitViewModel

  /******************** ViewControllers ********************/

  private lazy var historyListViewController: HistoryListViewController = {
    let viewModel = HistoryListViewModel()
    return HistoryListViewController(with: viewModel)
  }()

  private lazy var historyDetailsViewController: HistoryDetailsViewController = {
    let viewModel = HistoryDetailsViewModel()
    return HistoryDetailsViewController(with: viewModel)
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

  @available(*, unavailable)
  convenience init() {
    fatalError("init() has not been implemented.")
  }

  @available(*, unavailable)
  override init(nibName nibNameOrNil: String?,
                bundle nibBundleOrNil: Bundle?) {
    fatalError(
      "init(nibNameOrNil:nibBundleOrNil:) has not been implemented."
    )
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  init(with viewModel: HistorySplitViewModel = HistorySplitViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: .main)
  }

  private func setup() {
    setupSplitViewController()
    setupViewControllers()

//    let call = CallModel(id: 31,
//                         createdAt: "2018-04-19T09:38:41.000Z",
//                         direction: .outbound,
//                         sender: "Pierre-Baptiste Béchu",
//                         receiver: "06 46 62 12 33",
//                         phoneOperator: "NYC Office",
//                         duration: "120",
//                         isArchived: false,
//                         callType: .missed)
//
//
//    show(call: call)
  }

  private func setupSplitViewController() {
    preferredDisplayMode = .allVisible
    delegate = self

    addMasterChildToViewControllers()
    addDetailChildToViewControllers()
  }

  private func setupViewControllers() {
    setupMasterViewController()
    setupDetailViewController()
  }

  private func setupMasterViewController() {
    historyListViewController.didSelectCall = { [weak self] call in
      self?.show(call: call)
    }
  }

  private func setupDetailViewController() {
    historyDetailsViewController.shouldArchive = { [weak self] call in
      self?.historyDetailsViewController.navigationController?
        .navigationController?.popViewController(animated: true)
      self?.historyDetailsViewController.call = nil
      self?.historyListViewController.archive(call: call)
    }
  }

  /// Add a master view controller embedded into a navigation view controlller
  /// to the view conrollers array.
  private func addMasterChildToViewControllers() {
    let navigationViewController =
      generateNavigationViewController(with: historyListViewController)
    historyListViewController.navigationItem.title = self.viewModel.historyTitle
    viewControllers.append(navigationViewController)
  }

  private func addDetailChildToViewControllers() {
    let navigationViewController =
      generateNavigationViewController(with: historyDetailsViewController)
    viewControllers.append(navigationViewController)
  }

  //----------------------------------------------------------------------------
  // MARK: - Navigation
  //----------------------------------------------------------------------------

  private func generateNavigationViewController(
    with rootViewController: UIViewController
  ) -> UINavigationController {
    let navigationViewController =
      UINavigationController(rootViewController: rootViewController)
    navigationViewController.navigationBar.barTintColor = .white
    //navigationViewController.navigationBar.tintColor = .black
    navigationViewController.navigationBar.prefersLargeTitles = true

    rootViewController.navigationItem.largeTitleDisplayMode = .always
    return navigationViewController
  }

  //----------------------------------------------------------------------------
  // MARK: - Detail view
  //----------------------------------------------------------------------------

  private func show(call: CallModel) {
    guard let historyDetailNavigationViewController =
            historyDetailsViewController.navigationController else {
      return
    }

    historyDetailsViewController.navigationItem.leftBarButtonItem =
      displayModeButtonItem
    historyDetailsViewController.navigationItem.leftItemsSupplementBackButton =
      true

    historyDetailsViewController.call = call

    showDetailViewController(historyDetailNavigationViewController, sender: nil)
  }

}

//==============================================================================
// MARK: - UISplitViewControllerDelegate
//==============================================================================

extension HistorySplitViewController: UISplitViewControllerDelegate {

  func splitViewController(
    _ splitViewController: UISplitViewController,
    collapseSecondary secondaryViewController: UIViewController,
    onto primaryViewController: UIViewController
  ) -> Bool {
    return true
  }

}
