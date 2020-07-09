//
//  CallDetailsPageViewController.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import UIKit

class CallDetailsPageViewController: UIViewController {
    private lazy var detailsView = view as! CallDetailsPageView
    private var viewModel: CallDetailsPageViewModel!
    
    static func instantiate(viewModel: CallDetailsPageViewModel) -> CallDetailsPageViewController {
        let viewController = StoryboardScene.CallDetailsPage.initialScene.instantiate()
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = .archive()
    }
}

class CallDetailsPageView: UIView {
    
}

extension UIBarButtonItem {
    static func archive() -> UIBarButtonItem {
        UIBarButtonItem(
            image: UIImage(systemName: "archivebox"),
            style: .plain,
            target: nil,
            action: nil)
    }
}
