//
//  ActivitiesCoordinator.swift
//  TestAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import Foundation
import UIKit

protocol ActivitiesSceneDelegate: class {
    func didSelectActivity()
    func closeDetailsPage()
}

class ActivitiesCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    var viewModel: ActivitiesViewModel!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        viewModel = ActivitiesViewModel(coordinatorDelegate: self)
        showActivitiesScene()
    }
    
    func showActivitiesScene() {
        navigationController.setViewControllers([configuredActivities(delegate: self)], animated: true)
    }
    
    func showActivityDetails() {
        navigationController.pushViewController(configuredActivityDetails(), animated: true)
    }
}

// MARK: - Private methods
extension ActivitiesCoordinator {
    
    private func configuredActivities(delegate: ActivitiesSceneDelegate?) -> ActivitiesViewController {
        ActivitiesViewController(viewModel: viewModel)
    }
    
    private func configuredActivityDetails() -> ActivityDetailsViewController {
        ActivityDetailsViewController(viewModel: viewModel)
    }
}

// MARK: - ActivitiesSceneDelegate
extension ActivitiesCoordinator: ActivitiesSceneDelegate {
    
    func didSelectActivity() {
        showActivityDetails()
    }
    
    func closeDetailsPage() {
        popViewController(animated: true)
    }
}
