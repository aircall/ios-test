//
//  ActivityDetailsViewController.swift
//  TestAircall
//
//  Created by Delphine Garcia on 30/06/2021.
//

import UIKit

class ActivityDetailsViewController: UIViewController {

    let viewModel: ActivitiesViewModel
    lazy var customView = view as! ActivityDetailsView
        
    init(viewModel: ActivitiesViewModel = ActivitiesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ActivityDetailsView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        setupNavigationItem()
        displayActivity()
        viewModel.bindArchiveStateToController = { [weak self] in
            guard let self = self else { return }
            self.handleArchiveResult()
        }
    }
}

// MARK: - Private methods
extension ActivityDetailsViewController {
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.archive,
                                                            style: .plain,
                                                            target: self, action: #selector(archive))
    }
    
    private func displayActivity() {
        if let activity = viewModel.selectedActivity {
            let activityUI = ActivityDetailsUI(activity)
            navigationItem.title = activityUI.date
            customView.displayActivity(activityUI)
        }
    }

    @objc private func archive() {
        viewModel.didPressArchive()
    }
    
    private func showAlert(title: String?, message: String?) {
        presentAlert(title: title, message: message)
    }
    
    private func handleArchiveResult() {
        switch viewModel.archiveState {
        case .ok:
            viewModel.closeDetailsPage()
        case .error:
            showAlert(title: "Generic_error".localized,
                      message: "Archive_error".localized)
        case .pending:
            break
        }
    }
}
