//
//  CommonUITests.swift
//  CommonUITests
//
//  Created by Rudy Frémont on 10/04/2021.
//

import XCTest
@testable import CommonUI
import Rswift

class CommonUITests: XCTestCase {

    /// R.Swift verify that all resources are available
    func testValidateRSwift() {
        do {
            try R.validate()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
