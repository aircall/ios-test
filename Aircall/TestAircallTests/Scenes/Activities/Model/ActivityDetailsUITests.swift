//
//  ActivityDetailsUITests.swift
//  TestAircallTests
//
//  Created by Delphine Garcia on 01/07/2021.
//

import XCTest
@testable import TestAircall

class ActivityDetailsUITests: XCTestCase {
    
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
        let activitydetailsUI = ActivityDetailsUI(activity)
        
        //Then
        XCTAssertEqual(activitydetailsUI.date, "Apr. 18, 16:53")
    }

    func testInit_inbound_answered() {
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
        let activitydetailsUI = ActivityDetailsUI(activity)
        
        //Then
        XCTAssertEqual(activitydetailsUI.call, "06 19 18 23 92")
        XCTAssertEqual(activitydetailsUI.picto, UIImage.arrowDownLeft)
        XCTAssertEqual(activitydetailsUI.legend, "Incoming call answered")
    }
    
    func testInit_inbound_missed() {
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
        let activitydetailsUI = ActivityDetailsUI(activity)
        
        //Then
        XCTAssertEqual(activitydetailsUI.call, "06 19 18 23 92")
        XCTAssertEqual(activitydetailsUI.picto, UIImage.arrowDownLeft)
        XCTAssertEqual(activitydetailsUI.legend, "Incoming call missed")
    }
    
    func testInit_inbound_voicemail() {
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
        let activitydetailsUI = ActivityDetailsUI(activity)
        
        //Then
        XCTAssertEqual(activitydetailsUI.call, "06 19 18 23 92")
        XCTAssertEqual(activitydetailsUI.picto, UIImage.arrowDownLeft)
        XCTAssertEqual(activitydetailsUI.legend, "Incoming voicemail")
    }
    
    func testInit_outbound_answered() {
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
        let activitydetailsUI = ActivityDetailsUI(activity)
        
        //Then
        XCTAssertEqual(activitydetailsUI.call, "06 34 45 74 34")
        XCTAssertEqual(activitydetailsUI.picto, UIImage.arrowUpRight)
        XCTAssertEqual(activitydetailsUI.legend, "Outcoming call answered")
    }
    
    func testInit_outbound_missed() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .outbound,
                                from: "Xavier Durant",
                                to: "06 34 45 74 34",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .missed)

        //When
        let activitydetailsUI = ActivityDetailsUI(activity)
        
        //Then
        XCTAssertEqual(activitydetailsUI.call, "06 34 45 74 34")
        XCTAssertEqual(activitydetailsUI.picto, UIImage.arrowUpRight)
        XCTAssertEqual(activitydetailsUI.legend, "Outcoming call missed")
    }
    
    func testInit_outbound_voicemail() {
        //Given
        let activity = Activity(id: 7832,
                                creationDate: "2018-04-18T16:53:22.000Z".toDate(format: .network) ?? Date(),
                                direction: .outbound,
                                from: "Xavier Durant",
                                to: "06 34 45 74 34",
                                via: "Support FR",
                                duration: "180",
                                isArchived: false,
                                type: .voicemail)

        //When
        let activitydetailsUI = ActivityDetailsUI(activity)
        
        //Then
        XCTAssertEqual(activitydetailsUI.call, "06 34 45 74 34")
        XCTAssertEqual(activitydetailsUI.picto, UIImage.arrowUpRight)
        XCTAssertEqual(activitydetailsUI.legend, "Outcoming voicemail")
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
        let activitydetailsUI = ActivityDetailsUI(activity)
        
        //Then
        XCTAssertEqual(activitydetailsUI.call, "")
        XCTAssertEqual(activitydetailsUI.picto, nil)
        XCTAssertEqual(activitydetailsUI.legend, "")
    }
}
