//
//  PresenterExtensionsTests.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 28/06/2021.
//

import XCTest
@testable import Aircall_iOS_Test

class PresenterExtensionsTests: XCTestCase {

  func testStoryboardsExists() throws {
    XCTAssertNotNil(UIStoryboard.main)
  }

  func testViewControllersExists() throws {
    XCTAssertNotNil(UIViewController.activitiesViewController)
    XCTAssertNotNil(UIViewController.detailsViewController)
  }


}
