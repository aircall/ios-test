//
//  HistoryVM.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import Combine

class HistoryVM {

  // MARK: - Properties
  @Published private(set) var activities = [Activity]()
  @Published private(set) var isLoading = false
  @Published private(set) var isEmpty = false

  private var networkManager: NetworkManager
  private var cancellables = Set<AnyCancellable>()

  // MARK: - Initializer
  init(networkManager: NetworkManager = NetworkManager()) {
    self.networkManager = networkManager
    loadActivities()
  }

  // MARK: - Methods

  /// Network request to fetch all activities
  func loadActivities() {
    isLoading = true

    networkManager
      .request(Resource<[Activity]>.getActivities())
      .handleEvents(receiveCompletion: { _ in
        self.isLoading = false
      }, receiveCancel: {
        self.isLoading = false
      })
      .map({ (result: Result<[Activity], NetworkError>) -> [Activity] in
        switch result {
        case .success(let activities):
          return activities.filter { !$0.is_archived }
        case .failure(let error):
          print(error.localizedDescription)
          return []
        }
      })
      .eraseToAnyPublisher()
      .sink(receiveValue: { activities in
        self.activities = activities
        self.isEmpty = activities.isEmpty
      })
      .store(in: &cancellables)
  }

  /// Network request to reset & fetch again all activities
  func resetActivities() {
    isLoading = true

    networkManager
      .request(Resource<Call>.resetCalls())
      .handleEvents(receiveCompletion: { _ in
        self.isLoading = false
      }, receiveCancel: {
        self.isLoading = false
      })
      .flatMap({ _ in
        self.networkManager.request(Resource<[Activity]>.getActivities())
      })
      .map({ (result: Result<[Activity], NetworkError>) -> [Activity] in
        switch result {
        case .success(let activities):
          return activities.filter { !$0.is_archived }
        case .failure(let error):
          print(error.localizedDescription)
          return []
        }
      })
      .eraseToAnyPublisher()
      .sink(receiveValue: { activities in
        self.activities = activities
        self.isEmpty = activities.isEmpty
      })
      .store(in: &cancellables)
  }

  /// Network request to update specific activity
  func updateActivity(by id: Int) {
    networkManager
      .request(Resource<Activity>.updateActivitiesBy(id: id))
      .map { (result: Result<Activity, NetworkError>)  in
        switch result {
          case .success: self.activities = self.activities.filter { $0.id != id }
          case .failure(let error): print(error.localizedDescription)
        }
      }
      .eraseToAnyPublisher()
      .sink(receiveValue: { _ in
        self.isEmpty = self.activities.isEmpty
      })
      .store(in: &cancellables)
  }

}
