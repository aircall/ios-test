//
//  HistoryDetailsViewModelTests.swift
//  AircallLaurentTests
//
//  Created by Laurent on 30/04/2021.
//

import XCTest

final class HistoryDetailsViewModelMock: HistoryDetailsViewModelProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  var call: CallModel? {
    didSet {
      if let id = call?.id {
        let title = String(id)
        shouldUpdateTitle?(title)
      } else {
        shouldUpdateTitle?("")
      }
    }
  }

  let placeholderText = "Please select a call"

  /******************** Callbacks ********************/

  var shouldUpdateTitle: ((String) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

  func addNote() {
  }

  func tag() {
  }

  func assign() {
  }

}

class HistoryDetailsViewModelTests: XCTestCase {

  func test_call_update() throws {
    let mockViewModel = HistoryDetailsViewModelMock()

    let expectation = XCTestExpectation(description: "update title callback")

    let expectedId = 1
    mockViewModel.shouldUpdateTitle = { title in
      XCTAssert(title == String(expectedId))
      expectation.fulfill()
    }

    let call = CallModel(id: expectedId,
                         createdAt: "",
                         direction: .inbound,
                         sender: "",
                         receiver: "",
                         phoneOperator: "",
                         duration: "",
                         isArchived: false,
                         callType: .answered)


    mockViewModel.call = call

    wait(for: [expectation], timeout: 10.0)
  }


}
