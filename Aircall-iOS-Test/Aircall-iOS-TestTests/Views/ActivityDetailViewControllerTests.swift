//
//  ActivityDetailViewControllerTests.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 28/06/2021.
//

import XCTest
@testable import Aircall_iOS_Test

class ActivityDetailViewControllerTests: XCTestCase {

  func testLoading() throws {
    let viewModel = ActivityViewModelMock()
    let source = UIViewController.detailsViewController as! ActivityDetailViewController
    source.viewModel = viewModel
    source.activity = EntitiesMock.activity
    XCTAssertEqual(viewModel.onUpdate.count, 0)
    XCTAssertEqual(viewModel.state, .loadingData)

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = source
    window.makeKeyAndVisible()
    source.loadView()

    XCTAssertEqual(viewModel.onUpdate.count, 1)
    XCTAssertEqual(viewModel.state, .loadingData)
  }

  func testTapOnArchive() {
    let viewModel = ActivityViewModelMock()
    let source = UIViewController.detailsViewController as! ActivityDetailViewController
    source.viewModel = viewModel

    source.didTapOnArchive(UIBarButtonItem())
    wait(for: [viewModel.archiveExpectation], timeout: 1)
    XCTAssertEqual(viewModel.state, .doneArchiving)
  }
}
