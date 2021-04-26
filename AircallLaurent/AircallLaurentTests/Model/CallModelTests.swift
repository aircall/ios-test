//
//  CallModelTests.swift
//  AircallLaurentTests
//
//  Created by Laurent on 26/04/2021.
//

import XCTest

class CallModelTests: XCTestCase {

  func test_decoding() throws {
      let id = 1
      let createdAt = "2018-04-19T09:38:41.000Z"
      let direction = "outbound"
      let from = "Pierre-Baptiste Béchu"
      let to = "06 46 62 12 33"
      let via = "NYC Office"
      let duration = "120"
      let isArchived = false
      let callType = "missed"
      let json = """
  {
          "id": \(id),
          "created_at": "\(createdAt)",
          "direction": "\(direction)",
          "from": "\(from)",
          "to": "\(to)",
          "via": "\(via)",
          "duration": "\(duration)",
          "is_archived": \(isArchived),
          "call_type": "\(callType)"
  }
  """
    guard let jsonData = json.data(using: .utf8) else {
      XCTFail("Cannot get json data")
      return
    }

    let call = try JSONDecoder().decode(CallModel.self, from: jsonData)

    XCTAssert(call.id == id)
    XCTAssert(call.createdAt == createdAt)
    XCTAssert(call.direction == Direction(rawValue: direction))
    XCTAssert(call.sender == from)
    XCTAssert(call.receiver == to)
    XCTAssert(call.phoneOperator == via)
    XCTAssert(call.duration == duration)
    XCTAssert(call.isArchived == isArchived)
    XCTAssert(call.callType == CallType(rawValue: callType))
  }

}
