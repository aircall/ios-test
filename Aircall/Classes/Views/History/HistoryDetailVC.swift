//
//  HistoryDetailVC.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

class HistoryDetailVC: UITableViewController {

  // MARK: - Properties
  static let identifier = "HistoryDetailVC"

  var viewModel: HistoryDetailVM?
  var didPressArchive: ((_ activity: Activity) -> Void)?

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavBar()
    setupTableView()
  }

  // MARK: - Setup UI

  /// UI Config Navigation Bar
  private func setupNavBar() {
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "archivebox"),
      style: UIBarButtonItem.Style.plain,
      target: self, action: #selector(self.archiveAction))

    guard let activity = viewModel?.activity else { return }
    navigationItem.title = activity.created.getFormattedDate(format: "MMM d, HH:mm")
  }

  /// UI Config TableView
  private func setupTableView() {
    guard let viewModel = viewModel else { return }

    /// Register cell row
    viewModel.tableViewCells.forEach { cell in
      tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
    }

    /// Register Header & Footer view
    viewModel.sectionHeaderFooterViews.forEach { section in
      tableView.register(UINib(nibName: section, bundle: nil), forHeaderFooterViewReuseIdentifier: section)
    }

    tableView.layoutMargins = .zero
    tableView.separatorInset = .zero
    tableView.rowHeight = 65
    tableView.tableFooterView = UIView()
  }

  /// Send an action to parent VC to archive a call
  @objc func archiveAction() {
    guard let viewModel = viewModel,
          let didPressArchive = didPressArchive else { return }

    didPressArchive(viewModel.activity)
    navigationController?.popViewController(animated: true)
  }
}

// MARK: - Table view data source
extension HistoryDetailVC {

  override func numberOfSections(in tableView: UITableView) -> Int {
    guard let viewModel = viewModel else { return 0 }
    return viewModel.tableViewCells.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case HeaderSectionType.contact.rawValue:
      return 1
    case HeaderSectionType.call.rawValue:
      return 2
    default:
      return 0
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = viewModel else { return UITableViewCell() }
    let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.tableViewCells[indexPath.section], for: indexPath)

    guard let contactCell = cell as? HistoryDetailCell else { return cell }

    switch indexPath.section {
    case HeaderSectionType.contact.rawValue:
      contactCell.setupCell(at: indexPath, section: .contact, with: viewModel.activity)
    case HeaderSectionType.call.rawValue:
      contactCell.setupCell(at: indexPath, section: .call, with: viewModel.activity)
    default:
      break
    }

    return contactCell
  }

}

// MARK: - Table view delegate
extension HistoryDetailVC {

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }

  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    switch section {
    case HeaderSectionType.call.rawValue:
      return 125
    default:
      return 0
    }
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let headerView = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: HistoryDetailSectionHeaderView.reuseIdentifier
    ) as? HistoryDetailSectionHeaderView else { fatalError("Couln't find \(HistoryDetailSectionHeaderView.reuseIdentifier)") }

    guard let viewModel = viewModel,
          let headerSection = HeaderSectionType(rawValue: section) else { return nil }

    headerView.setupSectionHeader(at: headerSection, title: viewModel.sectionHeaderTitle[section], viewModel.activity)
    return headerView
  }

  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let footerView = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: HistoryDetailSectionFooterView.reuseIdentifier
    ) as? HistoryDetailSectionFooterView else { fatalError("Couln't find \(HistoryDetailSectionFooterView.reuseIdentifier)") }

    footerView.containerView.backgroundColor = .clear

    switch section {
    case HeaderSectionType.call.rawValue:
      return footerView
    default:
      return nil
    }
  }

}
