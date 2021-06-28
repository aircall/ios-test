//
//  ActivityListViewControllerTests.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 28/06/2021.
//

import XCTest
@testable import Aircall_iOS_Test

class ActivityListViewControllerTests: XCTestCase {

  func testLoading() throws {
    let viewModel = ActivityViewModelMock()
    let source = UIViewController.activitiesViewController as! ActivityListViewController
    source.viewModel = viewModel
    XCTAssertEqual(viewModel.onUpdate.count, 0)
    XCTAssertEqual(viewModel.state, .loadingData)

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = source
    window.makeKeyAndVisible()
    source.loadView()

    XCTAssertEqual(viewModel.onUpdate.count, 1)
    XCTAssertEqual(viewModel.state, .doneLoadingWithSuccess)
    wait(for: [viewModel.loadExpectation], timeout: 1)
  }

  func testTapOnRetry() {
    let viewModel = ActivityViewModelMock()
    let source = UIViewController.activitiesViewController as! ActivityListViewController
    source.viewModel = viewModel

    source.didTapOnRetry(UIButton())
    wait(for: [viewModel.retryExpectation], timeout: 1)
    XCTAssertEqual(viewModel.state, .doneLoadingWithSuccess)
  }

  func testTapOnReset() {
    let viewModel = ActivityViewModelMock()
    let source = UIViewController.activitiesViewController as! ActivityListViewController
    source.viewModel = viewModel

    source.didTapOnReset(UIButton())
    wait(for: [viewModel.resetExpectation], timeout: 1)
    XCTAssertEqual(viewModel.state, .doneLoadingWithSuccess)
  }
}
