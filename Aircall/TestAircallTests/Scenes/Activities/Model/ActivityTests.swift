//
//  ActivityTests.swift
//  TestAircallTests
//
//  Created by Delphine Garcia on 01/07/2021.
//

import XCTest
import NetworkingAircall
@testable import TestAircall

class ActivityTests: XCTestCase {
    
    func testInit() {
        //Given
        let activityNetwork = ActivityNWK(id: 7832,
                                          creationDate: "2018-04-18T16:53:22.000Z",
                                          direction: "inbound",
                                          from: "06 19 18 23 92",
                                          to: "Jonathan Anguelov",
                                          via: "Support FR",
                                          duration: "180",
                                          isArchived: false,
                                          type: "missed")

        //When
        let activity = Activity(activityNetwork)
        
        //Then
        XCTAssertEqual(activity.id, 7832)
        XCTAssertEqual(activity.creationDate, "2018-04-18T16:53:22.000Z".toDate(format: .network))
        XCTAssertEqual(activity.direction, .inbound)
        XCTAssertEqual(activity.from, "06 19 18 23 92")
        XCTAssertEqual(activity.to, "Jonathan Anguelov")
        XCTAssertEqual(activity.via, "Support FR")
        XCTAssertEqual(activity.duration, "180")
        XCTAssertEqual(activity.isArchived, false)
        XCTAssertEqual(activity.type, .missed)
    }
}
