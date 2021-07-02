//
//  ActivityDetailsViewControllerTests.swift
//  TestAircallTests
//
//  Created by Delphine Garcia on 02/07/2021.
//

import XCTest
@testable import TestAircall

class ActivityDetailsViewControllerTests: XCTestCase {
    
    private typealias Package = (sut: ActivityDetailsViewController,
                                 viewModel: ActivitiesViewModel)
    
    private func createSUT() -> Package {
        let viewModel = ActivitiesViewModel(repo: StubRepository(activities: Activity.sutActivities))
        let sut = ActivityDetailsViewController(viewModel: viewModel)
        return (sut, viewModel)
    }
}

extension ActivityDetailsViewControllerTests {
    
    func testDidLoad() {
        //Given
        let package = createSUT()
        package.viewModel.loadActivities()
        package.viewModel.didSelectItem(atRow: 0)
        //When
        package.sut.viewDidLoad()
        // Then
        XCTAssertNotEqual(package.sut.navigationItem.rightBarButtonItem, nil)
        XCTAssertEqual(package.sut.navigationItem.title, "Jan. 01, 00:00".localized)
    }
}
