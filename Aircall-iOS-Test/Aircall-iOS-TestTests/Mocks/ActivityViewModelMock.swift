//
//  ActivityViewModelMock.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 28/06/2021.
//

import XCTest
@testable import Aircall_iOS_Test

class ActivityViewModelMock: ActivityViewModelProtocol {

  var data: [Activity] = []
  var onUpdate: [(() -> Void)] = []
  var state: ActivityViewModelState = .loadingData

  let loadExpectation = XCTestExpectation(description: "load has been called")
  let retryExpectation = XCTestExpectation(description: "retry has been called")
  let archiveExpectation = XCTestExpectation(description: "archive(:) has been called")
  let resetExpectation = XCTestExpectation(description: "reset has been called")
  let swipeExpectation = XCTestExpectation(description: "swipeActionConfiguration has been called")

  func load() {
    self.loadExpectation.fulfill()
    self.state = .doneLoadingWithSuccess
  }

  func retry() {
    self.retryExpectation.fulfill()
    self.state = .doneLoadingWithSuccess
  }

  func archive(_ activity: Activity) {
    self.archiveExpectation.fulfill()
    self.state = .doneArchiving
  }

  func reset() {
    self.resetExpectation.fulfill()
    self.state = .doneLoadingWithSuccess
  }

  func swipeActionConfiguration(at index: Int) -> UISwipeActionsConfiguration? {
    self.swipeExpectation.fulfill()
    return nil
  }
}
