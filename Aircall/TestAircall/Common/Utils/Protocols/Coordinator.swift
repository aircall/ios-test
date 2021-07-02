//
//  Coordinator.swift
//  TestAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func popViewController(animated: Bool)
}

extension Coordinator {
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        if childCoordinators.first(where: { $0 === coordinator }) == nil {
            childCoordinators.append(coordinator)
        }
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}
