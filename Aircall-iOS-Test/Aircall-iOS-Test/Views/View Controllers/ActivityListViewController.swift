//
//  ActivityListViewController.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import UIKit

class ActivityListViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var informationLabel: UILabel!
  @IBOutlet private weak var retryButton: UIButton!
  @IBOutlet private weak var resetButton: UIButton!

  // Injected properties
  var viewModel: ActivityViewModelProtocol!

  // Presenter - No need to init it right away - But would be better to inject for testing purpose though,
  private lazy var presenter: ActivityListPresenterProtocol = {
    return ActivityListPresenter(source: self)
  }()


  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.viewModel != nil, "ViewModel must have been injected")
    self.prepareLayout()
    self.configureViewModel()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if let selectedRow = self.tableView.indexPathForSelectedRow {
      self.tableView.deselectRow(at: selectedRow, animated: true)
    }
  }


  // MARK: - User actions

  @IBAction func didTapOnRetry(_ sender: UIButton) {
    self.viewModel.retry()
  }

  @IBAction func didTapOnReset(_ sender: UIButton) {
    self.viewModel.reset()
  }


  // MARK: - Private API

  /// View model configuration.
  /// Loads the list from the server, and immediately appends a local closure to
  /// the viewModel's `onUpdate` property to react to any change in the view model seamlessly
  private func configureViewModel() {
    self.viewModel.load()
    self.viewModel.onUpdate.append { [weak self] in
      guard let self = self else { return }
      switch self.viewModel.state {
      case .loadingData: self.layoutForLoading()
      case .doneLoadingWithSuccess: self.layoutForSuccess()
      case .doneLoadingWithFailure: self.layoutForFailure()
      case .doneArchiving: self.layoutForSuccess()
      }
    }
  }

  /// Prepares the layout
  private func prepareLayout() {
    self.tableView.isHidden = true
    self.informationLabel.isHidden = true
    self.retryButton.isHidden = true
    self.resetButton.isHidden = true

    self.tableView.tableFooterView = UIView(frame: .zero)
  }

  /// Loading layout state
  private func layoutForLoading() {
    self.tableView.isHidden = true
    self.informationLabel.isHidden = false
    self.retryButton.isHidden = true
    self.resetButton.isHidden = true

    self.informationLabel.text = "Loading..."
  }

  /// Success layout state. Redirects to empty layout if needed.
  private func layoutForSuccess() {
    guard !self.viewModel.data.isEmpty else {
      self.layoutForEmpty()
      return
    }

    self.tableView.isHidden = false
    self.informationLabel.isHidden = true
    self.retryButton.isHidden = true
    self.resetButton.isHidden = true

    self.tableView.reloadData()
  }

  /// Failure layout state
  private func layoutForFailure() {
    self.tableView.isHidden = true
    self.informationLabel.isHidden = false
    self.retryButton.isHidden = false
    self.resetButton.isHidden = true

    self.informationLabel.text = "Whoopsie!\n\n\nIt seems we failed to retrieve the activities... Sorry about that.\n\nPlease tap the button down below to give another try!"
  }

  /// Empty layout state
  private func layoutForEmpty() {
    self.tableView.isHidden = true
    self.informationLabel.isHidden = false
    self.retryButton.isHidden = true
    self.resetButton.isHidden = false

    self.informationLabel.text = "Uh oh!\n\n\nYou've been on an archive fury.\n\nPlease tap the button down below to reset to the initial state ;)"
  }
}


// MARK: - Table view delegate & data source

extension ActivityListViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityList", for: indexPath) as! ActivityListCell
    cell.configure(with: self.viewModel.data[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    return self.viewModel.swipeActionConfiguration(at: indexPath.row)
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenter.showActivityDetails(viewModel: self.viewModel, activity: self.viewModel.data[indexPath.row])
  }

  func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    self.presenter.showActivityDetails(viewModel: self.viewModel, activity: self.viewModel.data[indexPath.row])
  }

}
