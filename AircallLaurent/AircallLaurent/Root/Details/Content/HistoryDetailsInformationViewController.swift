//
//  HistoryDetailsInformationViewController.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

class HistoryDetailsInformationViewController: UIViewController {

  //--------------------------------------------------------------------------
  // MARK: - Properties
  //--------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet weak var tableView: UITableView!
  
  /******************** TableView ********************/

  // Should be renamed to ViewModel.
  private let dataProvider: HistoryDetailsInformationDataProvider

  private let tableViewDataSource: HistoryDetailsInformationDataSource

  private let tableViewDelegate: HistoryDetailsInformationDelegate

  /******************** Callbacks ********************/

  var didFail: ((Error) -> Void)?

  var didTapDetail: ((CallModel) -> Void)?

  //--------------------------------------------------------------------------
  // MARK: - Lifecycle
  //--------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  //--------------------------------------------------------------------------
  // MARK: - Initialization
  //--------------------------------------------------------------------------

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

  init(
    with dataProvider: HistoryDetailsInformationDataProvider
      = HistoryDetailsInformationDataProvider()
  ) {
    self.dataProvider = dataProvider
    tableViewDataSource = HistoryDetailsInformationDataSource(with: dataProvider)
    tableViewDelegate = HistoryDetailsInformationDelegate(with: dataProvider)

    super.init(nibName: nil, bundle: .main)
  }

  private func setup() {
    setupView()
    setupDataProvider()
    setupTableView()
  }

  private func setupView() {
    view.backgroundColor = .clear
  }

  private func setupDataProvider() {
    dataProvider.shouldRegisterCells = { [weak self] items in
      guard let self = self else { return }
      for item in items {
        item.register(on: self.tableView)
      }
    }
    
    dataProvider.dataDidChange = { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    }

    dataProvider.dataDidClear = { [weak self] in
      self?.tableView.reloadData()
    }

    dataProvider.didSelectAcessory = { [weak self] call in
      self?.didTapDetail?(call)
    }
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
    tableView.bounces = false
    tableView.isScrollEnabled = false

    tableView.tableFooterView = UIView()
  }

  private func setupTableViewDataSource() {
    tableView.dataSource = tableViewDataSource
  }

  private func setupTableViewDelegate() {
    tableView.delegate = tableViewDelegate
  }

  //--------------------------------------------------------------------------
  // MARK: - Update
  //--------------------------------------------------------------------------

  func update(with call: CallModel) {
    dataProvider.update(with: call)
  }

}
