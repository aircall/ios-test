//
//  ActivitiesView.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import UIKit

class ActivitiesView: UIView {
    
    private let viewModel: ActivitiesViewModel
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: ActivityTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    @UsesAutoLayout var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var refreshControl = UIRefreshControl.init()
    
    init(frame: CGRect, viewModel: ActivitiesViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = UIColor.background
        initializePullDown()
        addAllSubviews()
        applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
// MARK: - Private methods
extension ActivitiesView {
    
    private func initializePullDown() {
        refreshControl.addTarget(self, action: #selector(resetData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func addAllSubviews() {
        addSubview(tableView)
        addSubview(messageLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
    }
    
    private func reloadDataInTableView() {
        tableView.isHidden = false
        messageLabel.isHidden = true
        UIView.transition(with: tableView,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }
    
    @objc private func resetData() {
        refreshControl.endRefreshing()
        viewModel.resetData()
    }
}

// MARK: - Internal methods
extension ActivitiesView {
    
    func setTableViewProvider(_ provider: TableViewProvider) {
        tableView.delegate = provider
        tableView.dataSource = provider
        reloadDataInTableView()
    }
    
    func displayMessage(_ message: String) {
        tableView.isHidden = true
        messageLabel.isHidden = false
        messageLabel.text = message
    }
}
