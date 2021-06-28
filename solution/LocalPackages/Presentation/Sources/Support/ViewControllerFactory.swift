//
//  ViewControllerFactory.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Foundation
import SwiftUI
import UIKit

public final class ViewControllerFactory {
    public class func createCallsListViewController(with viewModel: CallsListViewModel,
                                                    factory: CallsListViewControllersFactory) -> UIViewController {
        let view = CallsListView(viewModel)
        let viewController = UIHostingController(rootView: view)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        viewModel.router = DefaultCallsListViewRouter(navigationController: navigationController,
                                                      callsListViewControllersFactory: factory)
        return navigationController
    }

    public class func createCallsDetailViewController(with viewModel: CallDetailsViewModel) -> UIViewController {
        let view = CallDetailsView(viewModel)
        let viewController = UIHostingController(rootView: view)
        viewController.navigationItem.largeTitleDisplayMode = .never
        return viewController
    }
}
