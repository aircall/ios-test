//
//  ActivityViewModel.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation
import UIKit

/// Protocol declaration
protocol ActivityViewModelProtocol {
  var data: [Activity] { get }
  var onUpdate: [(() -> Void)] { get set }
  var state: ActivityViewModelState { get }

  func load()
  func retry()
  func archive(_ activity: Activity)
  func reset()

  func swipeActionConfiguration(at index: Int) -> UISwipeActionsConfiguration?
}

/// Implementation
class ActivityViewModel: ActivityViewModelProtocol {

  /// Used to perform network requests
  private let networker: NetworkerProtocol

  /// Raw / unfiltered data
  private var rawData: [Activity]

  /// Relevant subset of data from the `rawData` - Computed property
  /// Keeps only non-archived activities
  var data: [Activity] {
    get {
      return self.rawData.filter { !$0.isArchived }
    }
  }

  /// Array of update blocks
  var onUpdate: [(() -> Void)]

  /// Current state of the view model - Reactive property
  var state: ActivityViewModelState {
    didSet {
      self.onUpdate.forEach { $0() }
    }
  }

  // MARK: - Init

  init(networker: NetworkerProtocol) {
    self.networker = networker
    self.rawData = []
    self.state = .loadingData
    self.onUpdate = []
  }


  // MARK: - ActivityViewModelProtocol conformance

  /// Loads the list of activities from the server
  func load() {
    let request = ActivityListRequest()
    self.networker.request(request) { (result: Result<ActivityListOutput, Error>) in
      switch result {
      case .success(let output):
        self.rawData = output
        self.state = .doneLoadingWithSuccess
      default:
        self.rawData = []
        self.state = .doneLoadingWithFailure
      }
    }
  }

  /// Retries loading the list of activities from the server
  func retry() {
    self.load()
  }

  /// Archives the given activity
  /// - Parameter activity: the activity to archive
  func archive(_ activity: Activity) {
    let request = ArchiveActivityRequest(id: activity.id)
    self.networker.request(request) { (result: Result<Activity, Error>) in
      switch result {
      case .success(let output):
        if let index = self.rawData.firstIndex(of: activity) {
          self.rawData.remove(at: index)
          self.rawData.insert(output, at: index)
        }
      default: break
      }
      self.state = .doneArchiving
    }
  }

  /// Resets the list of activities from the server
  /// Resets all `isArchived` status to `false`
  /// Subsequentially calls `load` to reload the list of activities from the server
  func reset() {
    self.state = .loadingData
    let request = ResetActivitiesRequest()
    self.networker.request(request) { (result: Result<ResetActivitiesOutput, Error>) in
      self.load()
    }
  }


  /// Configures the swipe action
  /// - Parameter index: the index within the `data` array
  /// - Returns: a fully configured swipe action configuration
  func swipeActionConfiguration(at index: Int) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal, title: "Archive") { [weak self] (_, _, completionHandler) in
      guard let self = self else {
        completionHandler(false)
        return
      }
      self.archive(self.data[index])
      completionHandler(true)
    }
    action.backgroundColor = .systemOrange

    return UISwipeActionsConfiguration(actions: [action])
  }

}

// Used to represent the current state of the activity view model
enum ActivityViewModelState {
  case loadingData
  case doneLoadingWithSuccess
  case doneLoadingWithFailure
  case doneArchiving
}
