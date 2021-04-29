//
//  HistoryListViewController.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.
//

import UIKit

class HistoryListViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet weak var tableView: UITableView!

  /******************** TableView ********************/

  private let viewModel: HistoryListViewModel

  private let tableViewDataSource: HistoryListDataSource

  private let tableViewDelegate: HistoryListDelegate

  /******************** Callbacks ********************/

  var didSelectCall: ((CallModel) -> Void)?

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

  init(with viewModel: HistoryListViewModel) {
    self.viewModel = viewModel
    tableViewDataSource = HistoryListDataSource(with: viewModel.dataProvider)
    tableViewDelegate = HistoryListDelegate(with: viewModel.dataProvider)

    super.init(nibName: nil, bundle: .main)
  }

  private func setup() {
    setupView()
    setupViewModel()
    setupTableView()

    viewModel.fetchCalls()
  }

  private func setupView() {
    view.backgroundColor = .white
  }

  private func setupViewModel() {
    viewModel.dataProvider.shouldRegisterCells = { [weak self] items in
      guard let self = self else { return }
      for item in items {
        item.register(on: self.tableView)
      }
    }

    viewModel.dataProvider.dataDidChange = { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    }

    viewModel.dataProvider.dataDidClear = { [weak self] in
      self?.tableView.reloadData()
    }

    viewModel.dataProvider.didSelect = { [weak self] call in
      self?.didSelectCall?(call)
    }

//    viewModel.dataProvider.didSelectAcessory = { [weak self] call in
//      self?.didTapDetail?(call)
//    }
  }

  private func setupTableView() {
    setupTableViewStyle()
    setupTableViewDataSource()
    setupTableViewDelegate()
  }

  private func setupTableViewStyle() {
    tableView.backgroundColor = .clear
    tableView.showsHorizontalScrollIndicator = false
    tableView.showsVerticalScrollIndicator = false
    tableView.bounces = true
  }

  private func setupTableViewDataSource() {
    tableView.dataSource = tableViewDataSource
  }

  private func setupTableViewDelegate() {
    tableView.delegate = tableViewDelegate
  }
  
}
