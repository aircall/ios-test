//
//  ArchiveViewModel.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 10/07/2021.
//

import Foundation

protocol ArchiveViewModelType: ObservableObject {
    init(apiManager: ApiManagerType)

    var isLoading: Bool { get }
    var error: String? { get }
    var isArchived: Bool { get }
    
    func archiveCall(id: Int)
}

class ArchiveViewModel: ArchiveViewModelType {
    private let apiManager: ApiManagerType

    @Published var isLoading  = false
    @Published var error: String?
    @Published var isArchived = false
    
    required init(apiManager: ApiManagerType) {
        self.apiManager = apiManager
    }
    
    func archiveCall(id: Int) {
        isLoading = true
        apiManager.archiveActivity(id: id) {  [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(_):
                self.isArchived = true
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}
