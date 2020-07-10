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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }
    
    func bind() {
        detailsView.bind(call: viewModel.call)
    }
}

class CallDetailsPageView: UIView {
    @IBOutlet private var directionIcon: UIImageView!
    @IBOutlet private var callNumberLabel: UILabel!
    @IBOutlet private var callTimeLabel: UILabel!
    @IBOutlet private var callInfoLabel: UILabel!
    @IBOutlet private var durationLabel: UILabel!
    
    func bind(call: Call) {
        DirectionViewComponent.render(call.direction, in: directionIcon)
        CallNumberViewComponent.render(call, in: callNumberLabel)
        CallInfoViewComponent.render(call, detailed: true, in: callInfoLabel)
        CallDurationViewComponent.render(call.duration, status: call.callType, in: durationLabel)
        
        callTimeLabel.text = DateConverter.string(call.createdAt, to: .hour)
    }
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
