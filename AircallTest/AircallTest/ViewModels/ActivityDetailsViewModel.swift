//
//  ActivityDetailsViewModel.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 06/07/2021.
//

import Foundation

protocol ActivityDetailsViewModelType: LoadableViewModelType {
    init(apiManager: ApiManagerType, id: Int)
    
    var id: Int { get }
    var apiManager: ApiManagerType { get }
}

class ActivityDetailsViewModel: ActivityDetailsViewModelType {
    var apiManager: ApiManagerType
    var id: Int
    
    @Published var state: LoadingState<ActivityDetailsViewData> = .idle
    
    required init(apiManager: ApiManagerType, id: Int) {
        self.apiManager = apiManager
        self.id = id
    }
    
    func load() {
        state = .loading
        apiManager.getActivity(id: id) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let activity):
                let viewData = ActivityDetailsViewData(activity: activity)
                self.state = .loaded(viewData)
            case .failure(let error):
                self.state = .failed(error)
            }
        }
    }
}
