//
//  HistoryDetailVC.swift
//  History
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit
import CommonUI

/// The view controller to display history item detail
final class HistoryDetailVC: UITableViewController {
    
    //retain coordinator - when the VC will pop the coordinator will be deleted
    var coordinator: HistoryDetailCoordinator?
    
    private let viewModel: HistoryDetailVM
    
    init(style: UITableView.Style, viewmodel: HistoryDetailVM) {
        self.viewModel = viewmodel
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        //Add footer View
        let footerView = R.nib.historyDetailFooterView.firstView(owner: nil)
        tableView.tableFooterView = footerView
        
        // No cell selection for the screen
        tableView.allowsSelection = false
        
        // Register cell
        tableView.register(R.nib.historyItemTableViewCell)
        
        // Add "Archive" button to archive the current history item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "archivebox"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(archiveAction))
        navigationItem.largeTitleDisplayMode = .never

        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionsCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyItemTableViewCell,
                                                       for: indexPath) else { return UITableViewCell() }
        cell.configure(model: viewModel.cellViewModel(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //Set placeholder text for height calculation
        //the real text will be defined with willDisplayHeaderView by using attributedText
        //This is to avoid defining a custom header label just to have an attributed string
        return " "
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        // Can set an attributed string for header text label
        header.textLabel?.attributedText = viewModel.headerForSection(section: section)
    }
}

extension HistoryDetailVC {
    
    /// Archive the history item - pop view controller on success - Display a popup error with retry action on failure
    @objc private func archiveAction() {
        
        // Display an activity indicator view in the middle of the screen
        startLoading()
        
        viewModel.archiveItem { [weak self] result in
            guard let self = self else { return }

            // Remove the activity indicator view
            self.stopLoading()

            switch result {
            case .success:
                //Item has beean archived, go back to the list
                self.navigationController?.popViewController(animated: true)
            case .failure:
                self.presentTechnicalAlertWithRetry { [weak self] _ in
                    self?.archiveAction()
                }
            }
        }
    }
}
