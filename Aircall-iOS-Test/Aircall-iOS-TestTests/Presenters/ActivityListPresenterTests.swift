//
//  ActivityListPresenterTests.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 28/06/2021.
//

import XCTest
@testable import Aircall_iOS_Test

class ActivityListPresenterTests: XCTestCase {

  func testInit() throws {
    let source = UIViewController()
    let presenter = ActivityListPresenter(source: source)

    XCTAssertEqual(presenter.source, source)
  }

  func testShowActivityDetailsWithSuccess() throws {
    let source = UINavigationController(rootViewController: UIViewController())
    let root = source.topViewController!
    let presenter = ActivityListPresenter(source: root)

    XCTAssertEqual(source.topViewController, root)

    let mockedResult: [NetworkerMock.MockedResult] = [("/activities", EntitiesMock.activitiesData)]
    let viewModel = ActivityViewModel(networker: NetworkerMock(results: mockedResult))
    viewModel.load()
    let activity = viewModel.data.first!

    presenter.showActivityDetails(viewModel: viewModel, activity: activity)
    RunLoop.current.run(until: Date())

    XCTAssertNotEqual(source.topViewController, root)
    XCTAssertTrue(source.topViewController is ActivityDetailViewController)
  }
}
