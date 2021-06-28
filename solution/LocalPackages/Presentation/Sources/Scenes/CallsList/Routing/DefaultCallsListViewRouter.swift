//
//  DefaultCallsListViewRouter.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Foundation
import UIKit

class DefaultCallsListViewRouter: CallsListViewRouter {

    weak var navigationController: UINavigationController?
    let callsListViewControllersFactory: CallsListViewControllersFactory

    init(navigationController: UINavigationController,
         callsListViewControllersFactory: CallsListViewControllersFactory) {
        self.navigationController = navigationController
        self.callsListViewControllersFactory = callsListViewControllersFactory
    }

    func perform(_ route: CallsListViewRoute) {
        switch route {
        case let .showDetail(call):
            let detailsViewController = callsListViewControllersFactory.makeCallDetailsViewController(for: call)
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
