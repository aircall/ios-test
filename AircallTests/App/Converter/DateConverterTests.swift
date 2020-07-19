//
//  DateConverterTests.swift
//  AircallTests
//
//  Created by JC on 19/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import XCTest
@testable import Aircall

class DateConverterTests: XCTestCase {
    func test__string__FormatIsHour__dateIsInCorrectFormat() {
        let locale = Locale(identifier: "fr_FR")
        let dateComponents = DateComponents(calendar: Calendar.current,
                                            year: 2020,
                                            month: 04,
                                            day: 11,
                                            hour: 23,
                                            minute: 42)
            .date!
        
        
        XCTAssertEqual(DateConverter.string(dateComponents, to: .hour, locale: locale),
                       "23:42")
    }
}
