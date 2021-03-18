//
//  HistoryTableVC.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit
import Combine

class HistoryVC: UITableViewController {

  // MARK: - Properties
  let viewModel = HistoryVM()
  let spinnerIndicator = UIActivityIndicatorView(style: .medium)

  var stateView: ACLStateView?

  private var cancellables = Set<AnyCancellable>()

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBar()
    setupSpinner()
    setupTableView()
    setupStateView()
    bindViewModel()
  }

  // MARK: - Setup UI
  private func setupNavBar() {
    navigationItem.title = "History"
  }

  private func setupSpinner() {
    spinnerIndicator.hidesWhenStopped = true
  }

  private func setupTableView() {
    tableView.register(
      UINib(nibName: "\(HistoryItemCell.self)", bundle: nil),
      forCellReuseIdentifier: HistoryItemCell.identifier
    )

    tableView.rowHeight = 65
    tableView.layoutMargins = .zero
    tableView.separatorInset = .zero
    tableView.tableFooterView = UIView()
    tableView.backgroundView = spinnerIndicator
  }

  private func setupStateView() {
    stateView = ACLStateView(message: "All calls are archived", buttonTitle: "Reset calls")
    stateView?.didPressActionButton = {[weak self] in
      guard let self = self else { return }
      self.viewModel.resetActivities()
      self.tableView.backgroundView = self.spinnerIndicator
    }
  }

  private func bindViewModel() {
    viewModel.$isLoading
      .sink {[unowned self] isLoading in
        if !isLoading {
          self.spinnerIndicator.stopAnimating()
        } else {
          self.spinnerIndicator.startAnimating()
        }
      }
      .store(in: &cancellables)

    viewModel.$activities
      .receive(on: DispatchQueue.main)
      .sink {[unowned self] _ in
        self.tableView.reloadData()
      }
      .store(in: &cancellables)

    viewModel.$isEmpty
      .sink {[unowned self] isEmpty in
        if !isEmpty { return }
        guard let stateView = stateView else { return }
        self.tableView.backgroundView = stateView
      }
      .store(in: &cancellables)
  }

  private func handleArhiveAction(by id: Int) {
    viewModel.updateActivity(by: id)
  }

  private func showDetailViewAt(_ index: Int) {
    guard let detailVC = UIStoryboard(
            name: "History",
            bundle: nil
    ).instantiateViewController(identifier: "HistoryDetail") as? HistoryDetailVC else { return }

    let detailViewModel = HistoryDetailVM(activity: viewModel.activities[index])
    detailVC.viewModel = detailViewModel
    detailVC.didPressArchive = {[weak self] activity in
      guard let self = self else { return }
      self.handleArhiveAction(by: activity.id)
    }

    navigationController?.pushViewController(detailVC, animated: true)
  }

}

// MARK: - Table view data source
extension HistoryVC {

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.activities.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HistoryItemCell.identifier,
            for: indexPath
    ) as? HistoryItemCell else { fatalError("Couln't find \(HistoryItemCell.identifier)") }

    cell.setupCellWith(viewModel.activities[indexPath.row])

    return cell
  }

}

// MARK: - Table view delegate
extension HistoryVC {

  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let archive = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
      guard let self = self else { return }
      self.handleArhiveAction(by: self.viewModel.activities[indexPath.row].id)
      completionHandler(true)
    }

    archive.image = UIImage(systemName: "archivebox.fill")
    archive.backgroundColor = .systemOrange

    let swipeActionConfig = UISwipeActionsConfiguration(actions: [archive])
    swipeActionConfig.performsFirstActionWithFullSwipe = true

    return swipeActionConfig
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showDetailViewAt(indexPath.row)
  }

  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    showDetailViewAt(indexPath.row)
  }

}
