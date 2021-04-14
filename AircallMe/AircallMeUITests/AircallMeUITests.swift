//
//  AircallMeUITests.swift
//  AircallMeUITests
//
//  Created by Rudy Frémont on 10/04/2021.
//

import XCTest

class AircallMeUITests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    /// Simple UI Test
    func testAppSuccess() throws {

        let app = XCUIApplication()
        app.launch()
        
        //Wait for loading from heroku
        sleep(5)
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["made by Pierre-Baptiste Béchu"]/*[[".cells.staticTexts[\"made by Pierre-Baptiste Béchu\"]",".staticTexts[\"made by Pierre-Baptiste Béchu\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Apr 19, 11:38 AM"].buttons["archive"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["made by Jonathan Anguelov"]/*[[".cells.staticTexts[\"made by Jonathan Anguelov\"]",".staticTexts[\"made by Jonathan Anguelov\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Archive"]/*[[".cells.buttons[\"Archive\"]",".buttons[\"Archive\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["History"].buttons["Clear"].tap()
    }
    
    /// Simple UI Test with request failure by using command parameters
    func testAppFailureAccess() throws {

        let app = XCUIApplication()
        
        // Add "failure-mode" argument
        app.launchArguments.append("failure-mode")
        app.launch()
        
        //Wait for homescreen
        sleep(2)
        
        //An error popup is displayed
        let elementsQuery = XCUIApplication().alerts["Oups an error occurs"].scrollViews.otherElements
        
        //Tap on the Retry button
        elementsQuery.buttons["Retry"].tap()
        
        //Tap on the Cancel button
        elementsQuery.buttons["Cancel"].tap()
    }

    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
