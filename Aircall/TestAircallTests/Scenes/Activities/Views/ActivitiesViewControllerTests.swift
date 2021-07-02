//
//  ActivitiesSceneTests.swift
//  TestAircallTests
//
//  Created by Delphine Garcia on 27/06/2021.
//

import XCTest
@testable import TestAircall

class ActivitiesViewControllerTests: XCTestCase {
    
    var viewController: ActivitiesViewController!

    override func setUp() {
        super.setUp()
        viewController = ActivitiesViewController()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
}

extension ActivitiesViewControllerTests {
    
    func testDidLoad() {
        //When
        viewController.viewDidLoad()
        // Then
        XCTAssertEqual(viewController.navigationItem.title, "Activities_title".localized)
    }
    
    func testLoadingViewState() {
        // When
        viewController.updateViewBasedOn(.loading)
        let setTableViewDataSource = viewController.customView.tableView.dataSource
        let setTableViewDelegate = viewController.customView.tableView.delegate
        // Then
        XCTAssertTrue(((setTableViewDataSource as? LoadingTableViewProvider) != nil))
        XCTAssertTrue(((setTableViewDelegate as? LoadingTableViewProvider) != nil))
    }
    
    func testErrorViewState() {
        // When
        viewController.updateViewBasedOn(.error)
        // Then
        XCTAssertTrue(viewController.customView.tableView.isHidden)
        XCTAssertFalse(viewController.customView.messageLabel.isHidden)
        XCTAssertEqual(viewController.customView.messageLabel.text, "Generic_error".localized)
    }
    
    func testNoDataViewState() {
        // When
        viewController.updateViewBasedOn(.noData)
        // Then
        XCTAssertTrue(viewController.customView.tableView.isHidden)
        XCTAssertFalse(viewController.customView.messageLabel.isHidden)
        XCTAssertEqual(viewController.customView.messageLabel.text, "Activities_noData".localized)
    }
    
    func testResultViewState() {
        // When
        viewController.updateViewBasedOn(.result)
        let setTableViewDataSource = viewController.customView.tableView.dataSource
        let setTableViewDelegate = viewController.customView.tableView.delegate
        // Then
        XCTAssertTrue(((setTableViewDataSource as? ActivitiesTableViewProvider) != nil))
        XCTAssertTrue(((setTableViewDelegate as? ActivitiesTableViewProvider) != nil))
    }
}

