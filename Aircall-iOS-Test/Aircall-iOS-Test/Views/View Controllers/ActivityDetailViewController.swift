//
//  ActivityDetailViewController.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import UIKit

class ActivityDetailViewController: UIViewController {

  // Outlets
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var archiveBarButtonItem: UIBarButtonItem!

  // Injected properties
  var viewModel: ActivityViewModelProtocol!
  var activity: Activity!

  // Presenter - No need to init it right away - But would be better to inject for testing purpose though,
  private lazy var presenter: ActivityDetailsPresenterProtocol = {
    return ActivityDetailsPresenter(source: self)
  }()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(self.viewModel != nil, "ViewModel must have been injected")
    assert(self.activity != nil, "Activity must have been injected")
    self.configureViewModel()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tableView.reloadData()
  }

  // MARK: - Private API

  /// View model configuration.
  /// Appends a local closure to the viewModel's `onUpdate` property to react
  /// properly to `archive` changes in the view model seamlessly
  private func configureViewModel() {
    self.viewModel.onUpdate.append { [weak self] in
      guard let self = self else { return }
      switch self.viewModel.state {
      case .doneArchiving:
        if let activity = self.activity, self.viewModel.data.contains(activity) {
          self.presenter.presentErrorPopup()
        } else {
          self.presenter.pop()
        }
      default: break
      }
    }
  }


  // MARK: - User actions

  @IBAction func didTapOnArchive(_ sender: UIBarButtonItem) {
    self.viewModel.archive(self.activity)
  }
}


// MARK: - Table view delegate & data source

extension ActivityDetailViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return Sections.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Sections.allCases[section].rowsCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = Sections.allCases[indexPath.section].cellIdentifier(for: indexPath.row)
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ActivityConfigurableCell
    cell.configure(with: self.activity)
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return Sections.allCases[section].title
  }

  /*
   Kind of static cells inside not-a-UITableViewController
   Sorry in advance.
   */

  private enum Sections: CaseIterable {
    case general, detail

    var title: String {
      switch self {
      case .general: return "General information"
      case .detail: return "Activity information"
      }
    }

    var rowsCount: Int {
      switch self {
      case .general: return GeneralRows.allCases.count
      case .detail: return DetailRows.allCases.count
      }
    }

    func cellIdentifier(for row: Int) -> String {
      switch self {
      case .general: return GeneralRows.allCases[row].rawValue
      case .detail: return DetailRows.allCases[row].rawValue
      }
    }
  }

  private enum GeneralRows: String, CaseIterable {
    case fromTo = "FromToCell"
  }

  private enum DetailRows: String, CaseIterable {
    case duration = "DurationCell"
    case direction = "DirectionCell"
    case via = "ViaCell"
  }
}


