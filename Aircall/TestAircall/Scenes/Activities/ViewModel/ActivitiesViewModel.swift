//
//  ActivitiesViewModel.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import Foundation
import NetworkingAircall

class ActivitiesViewModel {
    
    var repository: DataRepository
    private(set) var activities: [Activity] = []
    private(set) var selectedActivity: Activity?
    private(set) var state = ActivitiesFlow.ViewState.loading {
        didSet {
            bindStateToController()
        }
    }
    private(set) var archiveState = ActivitiesFlow.ArchiveState.ok {
        didSet {
            bindArchiveStateToController()
        }
    }
    
    var bindStateToController : (() -> ()) = {}
    var bindArchiveStateToController : (() -> ()) = {}
    
    weak var coordinatorDelegate: ActivitiesSceneDelegate?
    
    init(repo: DataRepository = ActivitiesRepository(),
         coordinatorDelegate: ActivitiesSceneDelegate? = nil) {
        self.repository = repo
        self.coordinatorDelegate = coordinatorDelegate
    }
}

// MARK: - Internal methods
extension ActivitiesViewModel {
    
    func loadActivities() {
        state = .loading
        loadAllActivities()
    }
    
    func archiveActivity(id: Int, completion: @escaping (Error?) -> Void) {
        repository.archiveActivity(id: id) { [weak self] error in
            guard let self = self else { return }
            self.activities = self.repository.activities.filter { !$0.isArchived }
            self.state = (self.activities.isEmpty) ? .noData : .result
            completion(error)
        }
    }
    
    func resetData() {
        repository.resetData { [weak self] error in
            if error == nil {
                self?.loadAllActivities()
            }
        }
    }
    
    func didSelectItem(atRow index: Int) {
        selectedActivity = activities[index]
        coordinatorDelegate?.didSelectActivity()
    }
    
    func didMoveToArchive(atRow index: Int) {
        archive(activities[index])
    }
    
    func didPressArchive() {
        if let activity = selectedActivity {
            archive(activity)
        }
    }
    
    func closeDetailsPage() {
        coordinatorDelegate?.closeDetailsPage()
    }
}

// MARK: - Private methods
extension ActivitiesViewModel {
    
    private func archive(_ activity: Activity) {
        archiveState = .pending
        archiveActivity(id: activity.id) { [weak self] error in
            self?.archiveState = (error == nil) ? .ok : .error
        }
    }
    
    private func loadAllActivities() {
        repository.loadActivities { [weak self] error in
            guard let self = self else { return }
            self.activities = self.repository.activities.filter { !$0.isArchived }
            if let _ = error {
                self.state = .error
            } else {
                self.state = (self.activities.isEmpty) ? .noData : .result
            }
        }
    }
}
