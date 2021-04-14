//
//  HistoryListVC.swift
//  History
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit
import Wordings
import Common
import CommonUI

/// The view controller to display history list item
final class HistoryListVC: UITableViewController {
    
    /// retain coordinator - when the VC will pop the coordinator will be deleted
    var coordinator: HistoryCoordinator?
    
    private let viewModel: HistoryListVM
    
    init(style: UITableView.Style, viewmodel: HistoryListVM) {
        self.viewModel = viewmodel
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        //Register cell
        tableView.register(R.nib.historyItemTableViewCell)
        tableView.tableFooterView = UIView()
        
        // Add "clear" button to reset all archived item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "clear"),
                                                            style: .plain, target: self,
                                                            action: #selector(resetButtonAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyItemTableViewCell,
                                                       for: indexPath) else { return UITableViewCell()}
        
        cell.configure(model: viewModel.cellViewModel(at: indexPath))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVM = viewModel.cellViewModel(at: indexPath)

        //Demand to the coordiantor to display the detail view controller for the selected model
        coordinator?.displayDetail(for: cellVM.model)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Add a swipe action on cells to archive an item
        
        let archiveAction = UIContextualAction(style: .normal,
                                               title: LocalizedWords.historyListActionArchiveTitle()) { [weak self] (_, _, _) in
            self?.archiveAction(at: indexPath)
        }
        archiveAction.image = UIImage(systemName: "archivebox")
        archiveAction.backgroundColor = CommonUI.R.color.accentColor()
        return UISwipeActionsConfiguration(actions: [archiveAction])
    }
}

extension HistoryListVC {
    
    /// Retrieve history item list - Reload tableview on success - Display a popup error with retry action on failure
    private func updateList() {
        
        // Display an activity indicator view in the middle of the screen
        startLoading()
        
        viewModel.getHistoryList { [weak self] result in
            self?.manageResult(result: result) { [weak self] in
                self?.updateList()
            }
        }
    }
    
    /// Archive a history item - Reload tableview on success - Display a popup error with retry action on failure
    private func archiveAction(at indexPath: IndexPath) {
        
        // Display an activity indicator view in the middle of the screen
        startLoading()

        viewModel.archiveItem(at: indexPath) { [weak self] result in
            
            self?.manageResult(result: result) { [weak self] in
                self?.archiveAction(at: indexPath)
            }
        }
    }
    
    /// Clear "archived" status for all history items - Reload tableview on success - Display a popup error with retry action on failure
    @objc private func resetButtonAction() {
        
        // Display an activity indicator view in the middle of the screen
        startLoading()

        viewModel.resetArchiveStatus { [weak self] result in
            
            self?.manageResult(result: result) { [weak self] in
                self?.resetButtonAction()
            }
        }
    }
    
    /// Helper method to manage generic response - Reload tableview on success - Display a popup error with retry action on failure
    private func manageResult(result: Result<Void, HTTPStatusCode>, completion: @escaping () -> Void) {
        
        // Remove the activity indicator view
        stopLoading()
        
        switch result {
        case .success:
            tableView.reloadData()
        case .failure:
            //Error case - User can retry
            presentTechnicalAlertWithRetry { _ in completion() }
        }
    }
}
