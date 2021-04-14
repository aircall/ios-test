//
//  HistoryCoordinator.swift
//  History
//
//  Created by Rudy Frémont on 11/04/2021.
//

import UIKit
import Swinject
import Common
import Wordings

/// Coordinator for History tab
final public class HistoryCoordinator: Coordinator, RootCoordinator {

    /// Initi the main history coordinator with a resolver and a given navigation controller
    /// - Parameters:
    ///   - resolver: the resolver for Dependency Injection
    ///   - nav: The navigation controller for history tab
    public init(_ resolver: Resolver, nav: UINavigationController) {
        
        super.init(resolver)
        
        // Indicates title and image for the history tab bar item
        nav.tabBarItem.image = UIImage(systemName: "clock")
        nav.tabBarItem.title = LocalizedWords.tabbarHistoryTitle()
        
        // Create the History list view controller with the resolver
        let historyVC = resolver.resolve(HistoryListVC.self)!
        
        // Save the coordinator in the new view controller
        historyVC.coordinator = self
        
        nav.viewControllers = [historyVC]
        navigationController = nav
    }
    
    /// Return the view controller to use for the history tab (or menu)
    public var rootViewController: UIViewController? {
        return navigationController
    }
}

extension HistoryCoordinator {
    
    /// Create and display a view controller to display a detail view for a history item
    /// - Parameter model: the history item model
    func displayDetail(for model: HistoryModel) {
        
        guard let nav = navigationController else { return }
        
        // Create the History Detail coordinator with the resolver
        let coordinator = resolver.resolve(HistoryDetailCoordinator.self)
        
        // Start the coordinator
        coordinator?.start(from: nav, with: model)
    }
}
