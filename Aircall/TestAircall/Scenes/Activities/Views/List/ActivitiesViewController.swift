//
//  ActivitiesViewController.swift
//  TestAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import UIKit
import NetworkingAircall

class ActivitiesViewController: UIViewController {

    let viewModel: ActivitiesViewModel
    lazy var customView = view as! ActivitiesView
    
    let loadingTableViewProvider = LoadingTableViewProvider()
    lazy var contentTableViewProvider: ActivitiesTableViewProvider = {
        return ActivitiesTableViewProvider(viewModel)
    }()
    
    init(viewModel: ActivitiesViewModel = ActivitiesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ActivitiesView(frame: .zero, viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        viewModel.bindStateToController = { [weak self] in
            guard let self = self else { return }
            self.updateViewBasedOn(self.viewModel.state)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadActivities()
    }
}

// MARK: - Private methods
extension ActivitiesViewController {
    
    private func setupNavigationItem() {
        navigationItem.title = "Activities_title".localized
    }

    private func setTableViewProvider(_ provider: TableViewProvider) {
        customView.setTableViewProvider(provider)
    }
}

// MARK: - Internal methods
extension ActivitiesViewController {
    
    func updateViewBasedOn(_ state: ActivitiesFlow.ViewState) {
        switch state {
        case .loading:
            setTableViewProvider(loadingTableViewProvider)
        case .result:
            setTableViewProvider(contentTableViewProvider)
        case .noData:
            customView.displayMessage("Activities_noData".localized)
        case .error:
            customView.displayMessage("Generic_error".localized)
        }
    }
}
