//
//  AppCoordinator.swift
//  AircallMe
//
//  Created by Rudy Frémont on 11/04/2021.
//

import UIKit
import Common
import Swinject
import Wordings
import History

/// Application Coordinator
final class AppCoordinator {
    
    /// Demand to the coordinator to start its job
    /// - Parameters:
    ///   - window: the window to set the rootviewController
    ///   - resolver: the resolver for Dependency Injection
    func start(on window: UIWindow, with resolver: Resolver) {
        
        // No storyboard - create a tab bar controller
        let tabBarViewController = UITabBarController()
        var viewVC = [RootCoordinator]()
        
        // Populate tab bar
        viewVC.append(EmptyScreenCoordinator(title: LocalizedWords.tabbarTodoTitle(),
                                             image: UIImage(systemName: "list.dash")))
        
        if let history = resolver.resolve(HistoryCoordinator.self, argument: UINavigationController()) {
            viewVC.append(history)
        }

        viewVC.append(EmptyScreenCoordinator(title: LocalizedWords.tabbarKeypadTitle(),
                                             image: UIImage(systemName: "square.grid.3x2")))
        viewVC.append(EmptyScreenCoordinator(title: LocalizedWords.tabbarPeopleTitle(),
                                             image: UIImage(systemName: "person.2")))
        viewVC.append(EmptyScreenCoordinator(title: nil,
                                             image: UIImage(systemName: "gamecontroller")))
        
        // All child coordinators are conform to RootCoordinator protocol with variable rootViewController
        let viewcontrollers = viewVC.compactMap { $0.rootViewController }
        tabBarViewController.viewControllers = viewcontrollers
        
        // Specific for this test app -> select history tab
        tabBarViewController.selectedIndex = 1
        window.rootViewController = tabBarViewController
    }
}
