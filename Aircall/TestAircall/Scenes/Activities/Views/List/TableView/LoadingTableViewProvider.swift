//
//  LoadingTableViewProvider.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import Foundation
import UIKit

class LoadingTableViewProvider: NSObject {
    
    let numberOfRowsInSection: Int
    
    init(numberOfRowsInSection: Int = 3) {
        self.numberOfRowsInSection = numberOfRowsInSection
    }
}

// MARK: - TableViewProvider
extension LoadingTableViewProvider: TableViewProvider {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.reuseIdentifier, for: indexPath) as? ActivityTableViewCell else {
            return UITableViewCell()
        }
        cell.state = ActivitiesFlow.CellState.loading
        return cell
    }
}
