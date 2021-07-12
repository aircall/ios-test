//
//  AircallTestTests.swift
//  AircallTestTests
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import XCTest
@testable import AircallTest

class AircallTestTests: XCTestCase {
    private var apiManager: ApiManagerType!

    override func setUp() {
        super.setUp()
        self.apiManager = MockApiManager()
    }


    func testActivitiesData() throws {
        let viewModel = ActivitiesViewModel(apiManager: apiManager)
        
        XCTAssertEqual(viewModel.state, LoadingState.idle)
        
        viewModel.load()
        
        switch viewModel.state {
        case .loaded(let activities):
            XCTAssertEqual(activities.count, 3)
            let activity = activities[1]
            XCTAssertEqual(activity.day, "19/04")
            XCTAssertEqual(activity.hours, "11:38")
            XCTAssertEqual(activity.from, "From Johnny Halliday")
            XCTAssertEqual(activity.to, "06 45 13 53 91")
            XCTAssertEqual(activity.id, 7833)
        case .failed(let error):
            XCTFail("Error: \(error.localizedDescription)")
        case .empty:
            XCTFail("Data should not be empty")
        default: break
        }
    }
    
    func testActivityDetailsData() {
        let viewModel = ActivityDetailsViewModel(apiManager: apiManager, id: 7834)
        XCTAssertEqual(viewModel.id, 7834)
        XCTAssertEqual(viewModel.state, LoadingState.idle)
        
        viewModel.load()
        
        switch viewModel.state {
        case .loaded(let activity):
            XCTAssertEqual(activity.duration, "120 seconds")
            XCTAssertEqual(activity.from, "From Michel Drucker")
            XCTAssertEqual(activity.to, "To 06 46 62 12 33")
            XCTAssertEqual(activity.via, "Via France 2")
            XCTAssertEqual(activity.type, "missed call")
            XCTAssertEqual(activity.date, "2018-04-19T09:38:41.000Z".iso8601Date())
        case .failed(let error):
            XCTFail("Error: \(error.localizedDescription)")
        case .empty:
            XCTFail("Data should not be empty")
        default: break
        }
    }
    
    func testArchiveActivity() {
        let viewModel = ArchiveViewModel(apiManager: apiManager)
        XCTAssertEqual(viewModel.isArchived, false)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.error, nil)
        viewModel.archiveCall(id: 1234)
        XCTAssertEqual(viewModel.isArchived, true)
    }
}
