//
//  EmptyScreenCoordinator.swift
//  AircallMe
//
//  Created by Rudy Frémont on 11/04/2021.
//

import UIKit
import Common

/// Coordinator to create empty VC that allows to have 5 tabs for the demo app
final class EmptyScreenCoordinator: RootCoordinator {

    private var title: String?
    private var image: UIImage?
    
    init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    /// Return empty view controller with title and image for TabBarItem
    var rootViewController: UIViewController? {
        let viewController = UIViewController()
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }

 }
