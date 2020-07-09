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
        state: .init(calls: [
            Call(id: 1, createdAt: Date(), direction: .inbound, from: .contact("Foobar"), to: nil, via: "Office", duration: .seconds(0), isArchived: false, callType: .missed)
        ]))
    
    private lazy var dataSource = CallDataSource(tableView: tableView)
    private var bag: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        title = "Activity"
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bag.removeAll()
    }
    
    private func bind() {
        viewModel.$state.map(\.calls).sink { [dataSource] in
            dataSource.bind(calls: $0)
        }
        .store(in: &bag)
    }
}
