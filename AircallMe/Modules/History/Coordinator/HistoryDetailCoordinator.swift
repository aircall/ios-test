//
//  HistoryDetailCoordinator.swift
//  History
//
//  Created by Rudy Frémont on 11/04/2021.
//

import UIKit
import Common

/// Coordinator for the detail view controller
final class HistoryDetailCoordinator: Coordinator {
    
    /// Create and display a view controller to display a detail view for a history item
    /// - Parameters:
    ///   - navigationController: the navigation controller for pushing the detail view controller
    ///   - model: the history item model to use
    func start(from navigationController: UINavigationController, with model: HistoryModel) {
        
        // Create the History Detail view controller with the resolver
        let detailVC = resolver.resolve(HistoryDetailVC.self, argument: model)!
        
        // Save the coordinator in the new view controller
        detailVC.coordinator = self

        navigationController.pushViewController(detailVC, animated: true)
    }
}
