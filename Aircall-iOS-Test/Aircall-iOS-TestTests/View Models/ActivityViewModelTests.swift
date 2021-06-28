//
//  ActivityViewModelTests.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import XCTest
@testable import Aircall_iOS_Test

class ActivityViewModelTests: XCTestCase {

  // MARK: - Init

  /// Ensure the init methods sets every variables properly
  func testInit() throws {
    let viewModel = ActivityViewModel(networker: NetworkerMock())

    XCTAssertTrue(viewModel.onUpdate.isEmpty)
    XCTAssertTrue(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .loadingData)
  }

  /// Ensure that loading the list with success creates properly initialised models
  func testModelInit() throws {
    let mockedResult: [NetworkerMock.MockedResult] = [("/activities", EntitiesMock.activitiesData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    viewModel.load()
    let firstActivity = viewModel.data.first!

    XCTAssertEqual(firstActivity.id, 7834)
    XCTAssertEqual(firstActivity.createdAt, Formatters.shared.iso8601DateFormatter.date(from: "2018-04-19T09:38:41.000Z"))
    XCTAssertEqual(firstActivity.direction, .outbound)
    XCTAssertEqual(firstActivity.from, "Pierre-Baptiste Béchu")
    XCTAssertEqual(firstActivity.to, "06 46 62 12 33")
    XCTAssertEqual(firstActivity.via, "NYC Office")
    XCTAssertEqual(firstActivity.duration, "120")
    XCTAssertEqual(firstActivity.isArchived, false)
    XCTAssertEqual(firstActivity.callType, .missed)
  }


  // MARK: - Load

  // Ensure that loading the list with success exposes the fetched data and updates the state
  func testLoadWithSuccess() throws {
    let mockedResult: [NetworkerMock.MockedResult] = [("/activities", EntitiesMock.activitiesData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    XCTAssertTrue(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .loadingData)

    viewModel.load()

    XCTAssertFalse(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .doneLoadingWithSuccess)
  }

  // Ensure that loading the list with failure does not expose data and updates the state
  func testLoadWithFailure() throws {
    let viewModel = ActivityViewModel(networker: NetworkerMock())

    XCTAssertTrue(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .loadingData)

    viewModel.load()

    XCTAssertTrue(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .doneLoadingWithFailure)
  }


  // MARK: - Retry

  func testRetryWithSuccess() throws {
    let mockedResult: [NetworkerMock.MockedResult] = [("/activities", EntitiesMock.activitiesData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    XCTAssertTrue(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .loadingData)

    viewModel.retry()

    XCTAssertFalse(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .doneLoadingWithSuccess)
  }

  func testRetryWithFailure() throws {
    let viewModel = ActivityViewModel(networker: NetworkerMock())

    XCTAssertTrue(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .loadingData)

    viewModel.retry()

    XCTAssertTrue(viewModel.data.isEmpty)
    XCTAssertEqual(viewModel.state, .doneLoadingWithFailure)
  }


  // MARK: - Archive

  func testArchiveWithSuccess() throws {
    let mockedResult: [NetworkerMock.MockedResult] = [("/activities", EntitiesMock.activitiesData),
                                                      ("/activities/7834", EntitiesMock.archivedActivityData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    viewModel.load()

    let firstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 6)
    XCTAssertEqual(firstActivity.id, 7834)
    XCTAssertEqual(firstActivity.isArchived, false)

    viewModel.archive(firstActivity)

    let newFirstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 5)
    XCTAssertNotEqual(firstActivity.id, newFirstActivity.id)
    XCTAssertEqual(viewModel.state, .doneArchiving)
  }

  func testArchiveWithFailure() throws {
    let mockedResult: [NetworkerMock.MockedResult] = [("/activities", EntitiesMock.activitiesData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    viewModel.load()

    let firstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 6)
    XCTAssertEqual(firstActivity.id, 7834)
    XCTAssertEqual(firstActivity.isArchived, false)

    viewModel.archive(firstActivity)

    let newFirstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 6)
    XCTAssertEqual(firstActivity.id, newFirstActivity.id)
    XCTAssertEqual(viewModel.state, .doneArchiving)
  }


  // MARK: - Reset

  func testResetWithSuccess() {
    let mockedResult: [NetworkerMock.MockedResult] = [("/activities", EntitiesMock.archivedActivitiesData),
                                                      ("/reset", EntitiesMock.resetData),
                                                      ("/activities", EntitiesMock.activitiesData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    viewModel.load()

    let firstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 1)
    XCTAssertEqual(firstActivity.id, 7833)
    XCTAssertEqual(firstActivity.isArchived, false)

    viewModel.reset()

    let newFirstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 6)
    XCTAssertNotEqual(firstActivity.id, newFirstActivity.id)
    XCTAssertEqual(viewModel.state, .doneLoadingWithSuccess)
  }

  func testResetWithFailure() {
    let mockedResult: [NetworkerMock.MockedResult] = [("/activities", EntitiesMock.archivedActivitiesData),
                                                      ("/reset", EntitiesMock.resetData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    viewModel.load()

    let firstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 1)
    XCTAssertEqual(firstActivity.id, 7833)
    XCTAssertEqual(firstActivity.isArchived, false)

    viewModel.reset()

    XCTAssertEqual(viewModel.data.count, 0)
    XCTAssertEqual(viewModel.state, .doneLoadingWithFailure)
  }


  // MARK: - Miscellaneous

  func testReactiveState() throws {
    let mockedResult: [NetworkerMock.MockedResult] = [("/reset", EntitiesMock.resetData),
                                                      ("/activities", EntitiesMock.activitiesData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    XCTAssertEqual(viewModel.state, .loadingData)

    let expectation = XCTestExpectation(description: "onUpdate has been called")
    viewModel.onUpdate.append {
      expectation.fulfill()
    }

    viewModel.reset()

    XCTAssertEqual(viewModel.state, .doneLoadingWithSuccess)
    wait(for: [expectation], timeout: 1)
  }

  func testSwipeActionConfiguration() throws {
    let mockedResult: [NetworkerMock.MockedResult] = [("/reset", EntitiesMock.resetData),
                                                      ("/activities", EntitiesMock.activitiesData),
                                                      ("/activities/7834", EntitiesMock.archivedActivityData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))

    viewModel.reset()

    let action = viewModel.swipeActionConfiguration(at: 0)
    XCTAssertNotNil(action)
    XCTAssertEqual(action?.actions.count, 1)
    XCTAssertEqual(action?.actions.first?.style, .normal)
    XCTAssertEqual(action?.actions.first?.title, "Archive")
    XCTAssertEqual(action?.actions.first?.backgroundColor, .systemOrange)

    let firstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 6)
    XCTAssertEqual(firstActivity.id, 7834)
    XCTAssertEqual(firstActivity.isArchived, false)

    let completion: ((Bool) -> Void) = { _ in }
    action?.actions.first?.handler(UIContextualAction(), UIView(), completion)

    let newFirstActivity = viewModel.data.first!
    XCTAssertEqual(viewModel.data.count, 5)
    XCTAssertNotEqual(firstActivity.id, newFirstActivity.id)
    XCTAssertEqual(viewModel.state, .doneArchiving)
  }
}
