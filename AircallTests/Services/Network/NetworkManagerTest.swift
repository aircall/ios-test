//
//  NetworkManagerTest.swift
//  AircallTests
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import XCTest
import Combine
@testable import Aircall
class NetworkManagerTest: XCTestCase {

  let networkManager = NetworkManager()
  var cancellables = Set<AnyCancellable>()

  func testGetActivities() {
    let expectation = XCTestExpectation(description: "allActivities")
    let resource = Resource<[Activity]>.getActivities()

    networkManager
      .request(resource)
      .map { (result: Result<[Activity], NetworkError>) -> [Activity] in
        switch result {
          case .success(let activities):
            return activities
          default:
            return []
        }
      }
      .sink { activities in
        XCTAssertTrue(activities.count >= 1, "Result should be 1 or more")
        expectation.fulfill()
      }
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 2)
  }

  func testRestActivities() {
    let expectation = XCTestExpectation(description: "resetActivities")
    let resource = Resource<Call>.resetCalls()

    networkManager
      .request(resource)
      .sink(receiveValue: { (result) in
        switch result {
          case .success(let call):
            XCTAssertEqual(call.message, "done", "Response message should be done")
            expectation.fulfill()
          default:
            break
        }
      })
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 2)
  }

  func testUpdateActivity() {
    let expectation = XCTestExpectation(description: "updateActivity")
    let resource = Resource<Activity>.updateActivitiesBy(id: 7834)

    networkManager
      .request(resource)
      .sink(receiveValue: { (result) in
        switch result {
          case .success(let activity):
            XCTAssertEqual(activity.is_archived, true, "Result should be true")
            expectation.fulfill()
          default:
            break
        }
      })
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 2)
  }

}
