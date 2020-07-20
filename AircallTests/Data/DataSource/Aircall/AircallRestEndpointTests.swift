//
//  AircallRestDataSourceTests.swift
//  AircallTests
//
//  Created by JC on 19/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import XCTest
@testable import Aircall

class AircallTests: XCTestCase {
    func test__urlRelative__ItAppendPathAtTheEnd() {
        let url = URL(string: "https://google.com/api/")!
        
        XCTAssertEqual(AircallRestEndpoint.activities.url(relativeTo: url).absoluteString,
                       url.absoluteString + AircallRestEndpoint.activities.path)
        
    }
}
