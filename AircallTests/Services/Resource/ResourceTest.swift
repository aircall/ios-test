//
//  ResourceTest.swift
//  AircallTests
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import XCTest
@testable import Aircall

class ResourceTest: XCTestCase {

  func testResourceInit() {
    XCTAssertNotNil(
      Resource<String>(url: URL(string: "https://aircall.io/")!, params: ["":""], body: ["":""])
      ,"Resource should be init with one of required params"
    )
  }

  func testRequestNotNil() {
    XCTAssertNotNil(
      Resource<String>(url: URL(string: "https://aircall.io/")!).request,
      "Request should not be nil"
    )
  }

}
