//
//  ActivitiesViewModelTests.swift
//  TestAircallTests
//
//  Created by Delphine Garcia on 30/06/2021.
//

import XCTest
@testable import TestAircall

class ActivitiesViewModelTests: XCTestCase {
    
    private typealias Package = (sut: ActivitiesViewModel,
                                 coordinatorDelegate: StubCoordinator)
    
    private func createSUT() -> Package {
        let coordinatorDelegate = StubCoordinator()
        let sut = ActivitiesViewModel(repo: StubRepository(activities: Activity.sutActivities),
                                      coordinatorDelegate: coordinatorDelegate)
        return (sut, coordinatorDelegate)
    }

    func testLoadActivities() throws {
        //Given
        let package = createSUT()
        XCTAssertTrue(package.sut.activities.isEmpty)
        
        //When
        package.sut.loadActivities()
        
        //Then
        XCTAssertFalse(package.sut.activities.isEmpty)
        XCTAssertEqual(package.sut.activities.count, Activity.sutActivities.count - 1)
    }
    
    func testArchiveActivity() throws {
        //Given
        let package = createSUT()
        XCTAssertTrue(package.sut.activities.isEmpty)
        
        //When
        package.sut.archiveActivity(id: 1) { _ in }
        
        //Then
        XCTAssertFalse(package.sut.activities.isEmpty)
        XCTAssertEqual(package.sut.activities.count, Activity.sutActivities.count - 2)
    }
    
    func testResetActivity() throws {
        //Given
        let package = createSUT()
        XCTAssertTrue(package.sut.activities.isEmpty)
        
        //When
        package.sut.resetData()
        
        //Then
        XCTAssertFalse(package.sut.activities.isEmpty)
        XCTAssertEqual(package.sut.activities.count, Activity.sutActivities.count)
    }
    
    func testDidSelect() throws {
        //Given
        let package = createSUT()
        package.sut.loadActivities()
        XCTAssertFalse(package.sut.activities.isEmpty)
        
        //When
        package.sut.didSelectItem(atRow: 0)
        
        //Then
        XCTAssertEqual(package.sut.selectedActivity?.id, 1)
        XCTAssertTrue(package.coordinatorDelegate.didSelectActivityDidCalled)
    }
    
    func testCloseDetailsPage() throws {
        //Given
        let package = createSUT()
        
        //When
        package.sut.closeDetailsPage()
        
        //Then
        XCTAssertTrue(package.coordinatorDelegate.closeDetailsPageDidCalled)
    }
}

class StubRepository: DataRepository {
    
    var activities: [Activity]
    
    init(activities: [Activity]) {
        self.activities = activities
    }
    
    public func loadActivities(completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func archiveActivity(id: Int, completion: @escaping (Error?) -> Void) {
        var activity = activities[1]
        activity.isArchived = true
        activities[1] = activity
        completion(nil)
    }
    
    func resetData(completion: @escaping (Error?) -> Void) {
        var activity = activities[3]
        activity.isArchived = false
        activities[3] = activity
        completion(nil)
    }
}

class StubCoordinator: ActivitiesSceneDelegate {
    
    var didSelectActivityDidCalled = false
    var closeDetailsPageDidCalled = false
    
    func didSelectActivity() {
        didSelectActivityDidCalled = true
    }
    
    func closeDetailsPage() {
        closeDetailsPageDidCalled = true
    }
    
}

extension Activity {
    static let sutActivity1 = Activity(id: 1,
                                       creationDate: Date(timeIntervalSinceReferenceDate: 0),
                                       direction: .outbound,
                                       from: "Jonathan Anguelov",
                                       to: "06 45 13 53 91",
                                       via: "NYC Office",
                                       duration: "60",
                                       isArchived: false,
                                       type: .missed)
    static let sutActivity2 = Activity(id: 2,
                                       creationDate: Date(timeIntervalSinceReferenceDate: 0),
                                       direction: .inbound,
                                       from: "06 19 18 23 92",
                                       to: "Jonathan Anguelov",
                                       via: "Support FR",
                                       duration: "180",
                                       isArchived: false,
                                       type: .answered)
    static let sutActivity3 = Activity(id: 3,
                                       creationDate: Date(timeIntervalSinceReferenceDate: 0),
                                       direction: .outbound,
                                       from: "06 34 45 74 34",
                                       to: "Xavier Durand",
                                       via: "Support FR",
                                       duration: "60",
                                       isArchived: false,
                                       type: .missed)
    static let sutActivity4 = Activity(id: 3,
                                       creationDate: Date(timeIntervalSinceReferenceDate: 0),
                                       direction: .outbound,
                                       from: "06 34 45 74 34",
                                       to: "Xavier Durand",
                                       via: "Support FR",
                                       duration: "60",
                                       isArchived: true,
                                       type: .missed)
    

    
    static let sutActivities: [Activity] = [
        .sutActivity1,
        .sutActivity2,
        .sutActivity3,
        .sutActivity4
    ]
}
