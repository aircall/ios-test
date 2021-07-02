//
//  CoordinatorTests.swift
//  TestAirCallTests
//
//  Created by Delphine Garcia on 25/06/2021.
//

import XCTest
@testable import TestAircall

class CoordinatorTests: XCTestCase {
    
    private func createSUT() -> MockCoordinator {
        MockCoordinator()
    }
    
    func testStartMethod() {
        // Given
        let sut = createSUT()
        // When
        sut.start()
        // Then
        XCTAssertFalse(sut.navigationController.viewControllers.isEmpty)
    }
    
    func testChildCoordinatorsCollection() {
        // Given
        let sut = createSUT()
        let mockCoordinator = MockCoordinator()
        // When
        sut.addChildCoordinator(mockCoordinator)
        // Then
        XCTAssertNotNil(sut.childCoordinators.first(where: { $0 === mockCoordinator }))
        // When
        sut.addChildCoordinator(mockCoordinator)
        // Then
        XCTAssertEqual(sut.childCoordinators.count, 1)
        // When
        sut.removeChildCoordinator(mockCoordinator)
        // Then
        XCTAssertNil(sut.childCoordinators.first(where: { $0 === mockCoordinator }))
    }
    
    func testPop() {
        // Given
        let sut = createSUT()
        let mockViewController = UIViewController()
        // When
        sut.navigationController.setViewControllers([UIViewController(), mockViewController], animated: false)
        // Then
        XCTAssertNotNil(sut.navigationController.viewControllers.first(where: { $0 === mockViewController }))
        // When
        sut.popViewController(animated: false)
        // Then
        XCTAssertNil(sut.navigationController.viewControllers.first(where: { $0 === mockViewController }))
    }
}

class MockCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setViewControllers([UIViewController()], animated: false)
    }
}
