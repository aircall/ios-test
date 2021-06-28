//
//  CallTests.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

@testable import Domain
import XCTest

final class CallTests: XCTestCase {

    func testInitializer() throws {
        // Arrange
        let id: UInt = 7834
        let createdAt: Date = Date(timeIntervalSince1970: 1524130721.0)
        let direction: CallDirection = .outbound
        let from: String = "Pierre-Baptiste Béchu"
        let to: String = "06 46 62 12 33"
        let via: String = "NYC Office"
        let duration: String = "120"
        let isArchived: Bool = true
        let type: CallType = .missed

        // Act
        let call = Call(id: id,
                        createdAt: createdAt,
                        direction: direction,
                        from: from,
                        to: to,
                        via: via,
                        duration: duration,
                        isArchived: isArchived,
                        type: type)

        // Assert
        XCTAssertEqual(id, call.id)
        XCTAssertEqual(createdAt, call.createdAt)
        XCTAssertEqual(from, call.from)
        XCTAssertEqual(to, call.to)
        XCTAssertEqual(via, call.via)
        XCTAssertEqual(duration, call.duration)
        XCTAssertEqual(isArchived, call.isArchived)
        XCTAssertEqual(type, call.type)
    }
}
