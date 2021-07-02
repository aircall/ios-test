//
//  ActivitiesTableViewProvider.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import Foundation
import UIKit

class ActivitiesTableViewProvider: NSObject {

    let viewModel: ActivitiesViewModel
    
    init(_ viewModel: ActivitiesViewModel = ActivitiesViewModel()) {
        self.viewModel = viewModel
    }
}

// MARK: - TableViewProvider
extension ActivitiesTableViewProvider: TableViewProvider {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.reuseIdentifier, for: indexPath) as? ActivityTableViewCell else {
            return UITableViewCell()
        }
        let activity = viewModel.activities[indexPath.row]
        cell.state = ActivitiesFlow.CellState.result(ActivityUI(activity))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(atRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let archiveAction = UIContextualAction(style: .normal, title: "Archive_action".localized) { [weak self] (action, view, completionHandler) in
            self?.viewModel.didMoveToArchive(atRow: indexPath.row)
            completionHandler(true)
        }
        archiveAction.image = UIImage.archive
        archiveAction.backgroundColor = UIColor.accent

        return UISwipeActionsConfiguration(actions: [archiveAction])
    }
}
