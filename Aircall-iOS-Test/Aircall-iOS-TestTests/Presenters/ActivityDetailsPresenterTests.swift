//
//  ActivityDetailsPresenterTests.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 28/06/2021.
//

import XCTest
@testable import Aircall_iOS_Test

class ActivityDetailsPresenterTests: XCTestCase {

  func testInit() throws {
    let source = UIViewController()
    let presenter = ActivityDetailsPresenter(source: source)

    XCTAssertEqual(presenter.source, source)
  }

  func testPresentErrorPopup() throws {
    // For this test case, since we're *presenting*, we must have a real view hierarchy.
    let root = UIViewController()
    let source = UINavigationController(rootViewController: root)
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = source
    window.makeKeyAndVisible()
    source.loadView()
    let presenter = ActivityDetailsPresenter(source: source.topViewController!)

    XCTAssertEqual(source.topViewController, root)

    presenter.presentErrorPopup()
    RunLoop.current.run(until: Date())

    XCTAssertTrue(root.presentedViewController is UIAlertController)
  }

  func testPop() throws {
    let source = UINavigationController()
    source.viewControllers = [UIViewController(), UIViewController()]
    let root = source.topViewController!
    let presenter = ActivityDetailsPresenter(source: root)

    XCTAssertEqual(source.viewControllers.count, 2)

    presenter.pop()
    RunLoop.current.run(until: Date())

    XCTAssertEqual(source.viewControllers.count, 1)
  }
}
