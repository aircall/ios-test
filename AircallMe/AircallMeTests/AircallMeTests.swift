//
//  AircallMeTests.swift
//  AircallMeTests
//
//  Created by Rudy Frémont on 10/04/2021.
//

import XCTest
@testable import AircallMe
import Rswift
import SwinjectDynamic
import Swinject

class AircallMeTests: XCTestCase {

    /// R.Swift verify that all resources are available
    func testValidateRSwift() {
        do {
            try R.validate()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    /// Test the app coordinator result
    func testAppCoordinatorStart() throws {
        
        let window = UIWindow()
        let provider = DependencyProvider()
        let appCoordinator = AppCoordinator()
        appCoordinator.start(on: window, with: provider.resolver)
        
        let tabbarC = try XCTUnwrap(window.rootViewController as? UITabBarController, "rootviewcontroller is not a UITabBarController")
        let controllers = try XCTUnwrap(tabbarC.viewControllers, "UITabBarController do not have any viewcontroller")
        XCTAssertTrue(controllers.count == 5)
    }

}
