//
//  HistoryCoordinatorsTests.swift
//  HistoryTests
//
//  Created by Rudy Frémont on 13/04/2021.
//

import XCTest
@testable import History
import CommonUI

class HistoryCoordinatorsTests: XCTestCase {
    
    func testHistoryCoordinatorStart() throws {

        let nav = UINavigationController(rootViewController: UIViewController())
        let container = MockDependencyProvider()
        let coordinator = HistoryCoordinator(container.resolver, nav: nav)

        if let nav = coordinator.rootViewController as? UINavigationController {
            XCTAssertTrue(nav.viewControllers.first is HistoryListVC)
            coordinator.displayDetail(for: MockData.oneItem.fakeModel())
            
            // Execute runloop 1 times more to get pushed viewcontroller after
            RunLoop.current.run(until: Date())
            XCTAssertTrue(nav.viewControllers.last is HistoryDetailVC)
        } else {
            XCTFail("rootviewcontroller has to be a navigation controller")
        }
    }
    
}
