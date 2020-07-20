//
//  ActivityFeedViewController.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ActivityFeedPageViewController: UITableViewController {
    var viewModel: ActivityFeedPageViewModel = ActivityFeedPageViewModel(
        state: .init(calls: []),
        callRepository: CallRepositoryAdapter()
    )
    
    private lazy var dataSource = CallDataSource(tableView: tableView)
    private var bag: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        title = "Activity"
        
        viewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.selectAction(call: nil)
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bag.removeAll()
    }
    
    private func bind() {
        viewModel.$state.map(\.calls).receive(on: RunLoop.main).sink { [viewModel, dataSource] in
            dataSource.bind(calls: $0, selectAction: viewModel.selectAction(call:))
        }
        .store(in: &bag)
        
        viewModel.$state.map(\.selectedCall).receive(on: RunLoop.main).sink { [weak self] call in
            guard let `self` = self else { return }
            guard let call = call else {
                self.navigationController?.popToViewController(self, animated: true)
                return
            }

            self.showCallDetails(call: call)
        }
        .store(in: &bag)
    }
    
    private func showCallDetails(call: Call) {
        let viewController = CallDetailsPageViewController.instantiate(
            viewModel: CallDetailsPageViewModel(call: call)
        )
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
