//
//  HistoryListViewController.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.
//

import UIKit
import CoreData

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
    tableViewDataSource =
      HistoryListDataSource(with: viewModel.fetchedResultsController)
    tableViewDelegate =
      HistoryListDelegate(with: viewModel.fetchedResultsController)

    super.init(nibName: nil, bundle: .main)
  }

  private func setup() {
    setupView()
    setupNavigationBar()
    setupViewModel()
    setupTableView()

    viewModel.fetchCalls()
  }

  private func setupView() {
    view.backgroundColor = .white
  }

  private func setupNavigationBar() {
    let actionButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                       target: self,
                                       action: #selector(reset))
    navigationItem.rightBarButtonItem = actionButton
  }

  private func setupViewModel() {
    viewModel.willFetchedResultsControllerChangeContent = { [weak self] in
      self?.tableView.beginUpdates()
    }

    viewModel.didFetchedResultsControllerChangeContent = { [weak self] in
      self?.tableView.endUpdates()
      self?.tableView.reloadData()
    }

    viewModel.didFetchedResultsControllerChangeSectionInfo = {
      [weak self] type, sectionIndex in
      switch type {
        case .insert:
          self?.tableView.insertSections([sectionIndex], with: .fade)
        case .delete:
          self?.tableView.deleteSections([sectionIndex], with: .fade)
        default:
          break
      }
    }

    viewModel.didFetchedResultsControllerChangeSectionObject = {
      [weak self] type, indexPath, newIndexPath in
      switch type {
        case .insert:
          guard let newIndexPath = newIndexPath else { return }
          self?.tableView.insertRows(at: [newIndexPath], with: .fade)

        case .delete:
          guard let indexPath = indexPath else { return }
          self?.tableView.deleteRows(at: [indexPath], with: .fade)

        case .update:
          guard let indexPath = indexPath else { return }
          self?.tableView.reloadRows(at: [indexPath], with: .fade)

        case .move:
          guard let indexPath = indexPath else { return }
          self?.tableView.deleteRows(at: [indexPath], with: .fade)

          guard let newIndexPath = newIndexPath else { return }
          self?.tableView.insertRows(at: [newIndexPath], with: .fade)

        @unknown default: break
      }
    }

  }

  private func setupTableView() {
    setupTableViewStyle()
    setupTableViewDataSource()
    setupTableViewDelegate()
    setupTableViewCell()
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

    tableViewDelegate.didSelect = { [weak self] call in
      self?.didSelectCall?(call)
    }

    tableViewDelegate.didTapDetail = { [weak self] call in
      self?.viewModel.archive(call: call)
    }
  }

  private func setupTableViewCell() {
    let cellIdentifier = GenericTableViewCell.reuseIdentifier
    let cellClass = GenericTableViewCell.self
    let bundle = Bundle(for: cellClass)
    if bundle.path(forResource: cellIdentifier, ofType: "nib") != nil {
      let nib = UINib(nibName: cellIdentifier, bundle: bundle)
      tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    } else {
      tableView.register(cellClass, forCellReuseIdentifier: cellIdentifier)
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  /// Reset the archive state of all the calls
  @objc private func reset() {
    viewModel.resetArchiveState()
  }

  /// Archive a given call
  /// - Parameter call: A call to archive
  func archive(call: CallModel) {
    viewModel.archive(call: call)
  }
  
}

