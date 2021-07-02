//
//  ActivitiesRepository.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import Foundation
import NetworkingAircall

public protocol DataRepository {
    var activities: [Activity] { get }
    func loadActivities(completion: @escaping (Error?) -> Void)
    func archiveActivity(id: Int, completion: @escaping (Error?) -> Void)
    func resetData(completion: @escaping (Error?) -> Void)
}

enum RepositoryError: Error {
    case cantFetchData
    case cantArchive
}

/**
 The role of the repository is to retrieve the data from a `DataProvider` (Service and/or the DB layer) and provide a consistent model. It manages a cache of the data so that ViewModels always have one source of truth.
 */
public class ActivitiesRepository: DataRepository {
    
    public var activities: [Activity] = []
    
    private let dataProvider: DataProviderProtocol
    private var apiActivities: [ActivityNWK]?
    
    init(dataProvider: DataProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
    }
    
    public func loadActivities(completion: @escaping (Error?) -> Void) {
        guard activities.isEmpty else {
            completion(nil)
            return
        }
        // Adding minimum delay (simulate heavy request) to see shimmering
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.dataProvider.loadActivities { [weak self] result in
                guard let self = self else {
                    completion(RepositoryError.cantFetchData)
                    return
                }
                switch result {
                case .success(let resultActivities):
                    self.apiActivities = resultActivities
                    self.activities = resultActivities.map { Activity($0) }
                    completion(nil)
                case .failure(_):
                    completion(RepositoryError.cantFetchData)
                }
            }
        }
    }
    
    public func archiveActivity(id: Int, completion: @escaping (Error?) -> Void) {
        dataProvider.archiveActivity(id: id) { [weak self] error in
            guard let self = self else {
                completion(RepositoryError.cantArchive)
                return
            }
            if let _ = error {
                completion(RepositoryError.cantArchive)
            } else {
                if let index = self.activities.firstIndex(where: {$0.id == id }) {
                    var activity = self.activities[index]
                    activity.isArchived = true
                    self.activities[index] = activity
                    completion(nil)
                } else {
                    completion(RepositoryError.cantArchive)
                }
            }
        }
    }
    
    public func resetData(completion: @escaping (Error?) -> Void) {
        dataProvider.reset { [weak self] error in
            guard let self = self else { return }
            if error == nil {
                self.activities = []
            }
            completion(error)
        }
    }
}
