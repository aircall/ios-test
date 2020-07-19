//
//  CallTests.swift
//  AircallTests
//
//  Created by JC on 19/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import XCTest
@testable import Aircall

class CallTests: XCTestCase {
    func test__initDecoder__validData__ItReturnACall() {        
        let dict: [String : Any] = [
            "id": 1,
            "createdAt": Date().timeIntervalSinceReferenceDate,
            "direction": "outbound",
            "from": "Pierre-Baptiste Béchu",
            "to": "06 46 62 12 33",
            "via": "Home",
            "duration": "245",
            "isArchived": false,
            "callType": "answered"
            ]
        
        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
        
        XCTAssertNoThrow(try JSONDecoder().decode(Call.self, from: data))
    }
    
    func test__Encode__ItReturnDecodableResult() {
        let call = Call(id: 1,
                        createdAt: Date(),
                        direction: .outbound,
                        from: .contact("Foobar"),
                        to: .contact("Aircall"),
                        via: "Home",
                        duration: .seconds(245),
                        isArchived: false,
                        callType: .answered)
        
        let data = try! JSONEncoder().encode(call)
        
        XCTAssertNoThrow(try JSONDecoder().decode(Call.self, from: data))
    }
}
