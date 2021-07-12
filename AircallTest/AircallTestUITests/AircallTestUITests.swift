//
//  AircallTestUITests.swift
//  AircallTestUITests
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import XCTest

class AircallTestUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    /// Test if activities list is presented and list is filled
    func testActivitiesList() {
        let list = app.tables["activitiesList"]
        XCTAssertEqual(list.exists, true)
        XCTAssertEqual(list.children(matching: .cell).count, 3)

        let row = list.cells.element(boundBy: 1)
        XCTAssertEqual(row.exists, true)
        
        /// test if details view exists
        row.tap()
        XCTAssertEqual(app.staticTexts["typeText"].label, "MISSED CALL")
        
    }

    /// Test details view data
    func testDetailsView() {
        let list = app.tables["activitiesList"]
        XCTAssertEqual(list.exists, true)
        list.cells.element(boundBy: 2).tap()
        
        XCTAssertEqual(app.staticTexts["typeText"].label, "MISSED CALL")
        XCTAssertEqual(app.staticTexts["dateText"].label, "April 19, 2018")
        XCTAssertEqual(app.staticTexts["timeText"].label, "11:38 AM")
        XCTAssertEqual(app.staticTexts["toText"].label, "To 06 46 62 12 33")
        XCTAssertEqual(app.staticTexts["fromText"].label, "From Michel Drucker")
        XCTAssertEqual(app.staticTexts["viaText"].label, "Via France 2")
        
        /// ArchiveView should be visible only after tapping archive button
        let archiveView = app.staticTexts["archiveTitleText"]
        XCTAssertEqual(archiveView.exists, false)
        app.buttons["archiveButton"].tap()
        XCTAssertEqual(archiveView.exists, true)
    }
    
    /// Test if all elements in archive view are visible and view is dismissable
    func testArchiveView() {
        app.tables["activitiesList"].cells.element(boundBy: 0).tap()
        app.buttons["archiveButton"].tap()

        XCTAssertEqual(app.staticTexts["archiveTitleText"].label, "Archive call")
        XCTAssertEqual(app.staticTexts["bodyText"].label, "Do you really want to archive this call ?")
        XCTAssertEqual(app.buttons["confirmButton"].exists, true)
        
        /// After tapping cancel, view should be dismissed
        app.buttons["cancelButton"].tap()
        XCTAssertEqual(app.staticTexts["archiveTitleText"].exists, false)
    }
}

