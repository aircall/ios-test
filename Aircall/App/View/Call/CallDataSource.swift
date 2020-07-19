//
//  CallDataSource.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import UIKit
import Reusable

private enum Section {
    case main
}

class CallDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var selectAction: ((Call) -> Void)?
    private var calls: [Call] = []
    weak var tableView: UITableView?
    
    init(tableView: UITableView) {
        super.init()

        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func bind(calls: [Call], selectAction: @escaping (Call) -> Void) {
        self.calls = calls
        self.selectAction = selectAction
        
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CallViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: CallViewCell.self)
        let call = calls[indexPath.row]

        cell.bind(call: call)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let call = calls[indexPath.row]
        
        selectAction?(call)
    }
}
