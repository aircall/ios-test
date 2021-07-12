//
//  ActivitiesViewModel.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

protocol ActivitiesViewModelType: LoadableViewModelType {
    init(apiManager: ApiManagerType)
    
    var apiManager: ApiManagerType { get }
}

class ActivitiesViewModel:  ActivitiesViewModelType {
    let apiManager: ApiManagerType
    
    @Published var state: LoadingState<[ActivityRowViewData]> = .idle
    
    required init(apiManager: ApiManagerType) {
        self.apiManager = apiManager
    }
    
    func load() {
        state = .loading
        apiManager.getActivities { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let activities):
                // filter to show only non-archived calls
                let viewData = activities
                    .filter { !$0.isArchived }
                    .map { ActivityRowViewData(activity: $0) }
                // show empty state if data are empty
                if viewData.isEmpty {
                    self.state = .empty
                } else {
                    self.state = .loaded(viewData)
                }
            case .failure(let error):
                self.state = .failed(error)
            }
        }
    }
}
