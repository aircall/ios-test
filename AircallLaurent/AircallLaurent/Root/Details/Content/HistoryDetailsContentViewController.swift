//
//  HistoryDetailsContentViewController.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

class HistoryDetailsContentViewController: UIViewController {

  //--------------------------------------------------------------------------
  // MARK: - Properties
  //--------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet weak var tableView: UITableView!
  

  /******************** TableView ********************/

  // Should be renamed to ViewModel.
  private let dataProvider: HistoryDetailsContentDataProvider

  private let tableViewDataSource:
    HistoryDetailsContentDataSource

  private let tableViewDelegate: TableViewDelegate<HistoryDetailsContentDataProvider>

  /******************** Callbacks ********************/

  var didFail: ((Error) -> Void)?

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

  init(with dataProvider: HistoryDetailsContentDataProvider) {
      self.dataProvider = dataProvider
      tableViewDataSource = HistoryDetailsContentDataSource(with: dataProvider)
      tableViewDelegate = TableViewDelegate<HistoryDetailsContentDataProvider>(
        with: dataProvider
      )

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
      dataProvider.dataDidChange = { [weak self] in
          guard let self = self else { return }
          self.dataProvider.registerOn(self.tableView)
          self.tableView.reloadData()
      }

      dataProvider.dataDidClear = { [weak self] in
          self?.tableView.reloadData()
      }

      dataProvider.registerOn(tableView)
  }

  private func setupTableView() {
      setupTableViewStyle()
      setupTableViewDataSource()
      setupTableViewDelegate()
  }

  private func setupTableViewStyle() {
      tableView.backgroundColor = .clear
      tableView.separatorStyle = .none
      tableView.showsHorizontalScrollIndicator = false
      tableView.showsVerticalScrollIndicator = false
      tableView.bounces = true

      tableView.estimatedRowHeight = 74.0
      tableView.rowHeight = UITableView.automaticDimension
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

//  func update(from call: CallModel) {
//      dataProvider.updateData(with: list)
//  }

}
