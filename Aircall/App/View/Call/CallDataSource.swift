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

class CallDataSource: NSObject, UITableViewDelegate {
    private let dataSource: UITableViewDiffableDataSource<Section, Call>
    private var selectAction: ((Call) -> Void)?
    
    init(tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource(tableView: tableView,
                                                   cellProvider: Self.cell(for:at:call:))
        
        super.init()

        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    func bind(calls: [Call], selectAction: @escaping (Call) -> Void) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Call>()
        
        self.selectAction = selectAction
        
        snapshot.appendSections([.main])
        snapshot.appendItems(calls, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private static func cell(for tableView: UITableView, at indexPath: IndexPath, call: Call) -> UITableViewCell? {
        let cell: CallViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: CallViewCell.self)

        cell.bind(call: call)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let call = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        selectAction?(call)
    }
}
