//
//  ActivityUITests.swift
//  TestAircallTests
//
//  Created by Delphine Garcia on 01/07/2021.
//

import XCTest
@testable import TestAircall

class ActivityUITests: XCTestCase {
    
    func testInit_date() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .inbound,
                                from: "06 19 18 23 92",
                                to: "Jonathan Anguelov",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .missed)

        //When
        let activityUI = ActivityUI(activity)
        
        //Then
        XCTAssertEqual(activityUI.date, "Apr. 18 \n 16:53")
    }
    
    func testInit_inbound() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .inbound,
                                from: "06 19 18 23 92",
                                to: "Jonathan Anguelov",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .answered)

        //When
        let activityUI = ActivityUI(activity)
        
        //Then
        XCTAssertEqual(activityUI.call, "06 19 18 23 92")
        XCTAssertEqual(activityUI.picto, UIImage.arrowDownLeft)
        XCTAssertEqual(activityUI.legend, "on Support FR")
    }
    
    func testInit_outbound() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .outbound,
                                from: "Xavier Durant",
                                to: "06 34 45 74 34",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .answered)

        //When
        let activityUI = ActivityUI(activity)
        
        //Then
        XCTAssertEqual(activityUI.call, "06 34 45 74 34")
        XCTAssertEqual(activityUI.picto, UIImage.arrowUpRight)
        XCTAssertEqual(activityUI.legend, "made by Support FR")
    }
    
    func testInit_unknown() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .unknown,
                                from: "06 19 18 23 92",
                                to: "Jonathan Anguelov",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .answered)

        //When
        let activityUI = ActivityUI(activity)
        
        //Then
        XCTAssertEqual(activityUI.call, "")
        XCTAssertEqual(activityUI.picto, nil)
        XCTAssertEqual(activityUI.legend, "")
    }
    
    func testInit_answered() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .inbound,
                                from: "06 19 18 23 92",
                                to: "Jonathan Anguelov",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .answered)

        //When
        let activityUI = ActivityUI(activity)
        
        //Then
        XCTAssertEqual(activityUI.color, UIColor.accent)
    }
    
    func testInit_missed() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .inbound,
                                from: "06 19 18 23 92",
                                to: "Jonathan Anguelov",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .missed)

        //When
        let activityUI = ActivityUI(activity)
        
        //Then
        XCTAssertEqual(activityUI.color, UIColor.red)
    }
    
    func testInit_voicemail() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .inbound,
                                from: "06 19 18 23 92",
                                to: "Jonathan Anguelov",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .voicemail)

        //When
        let activityUI = ActivityUI(activity)
        
        //Then
        XCTAssertEqual(activityUI.color, UIColor.gray)
    }
}
