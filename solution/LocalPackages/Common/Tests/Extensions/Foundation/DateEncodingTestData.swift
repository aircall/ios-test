//
//  File.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import Foundation

struct DateEncodingTestData {
    let dateString: String
    let date: Date
    let jsonData: Data
    let invalidJSONData: Data
}

extension DateEncodingTestData: DefaultValueProvider {

    static var `default`: DateEncodingTestData {
        let dateString = "2018-04-19T09:38:41.000Z"
        let invalidDateString = "2018-04-19T09:38:41"
        let timeZone = TimeZone(abbreviation: "UTC")
        let components = DateComponents(timeZone: timeZone, year: 2018, month: 4, day: 19, hour: 9, minute: 38, second: 41)

        guard let date = Calendar.autoupdatingCurrent.date(from: components),
              let jsonData = "\"\(dateString)\"".data(using: .utf8),
              let invalidJSONData = "\"\(invalidDateString)\"".data(using: .utf8) else {
            fatalError("Failed to create test data")
        }
        let value = DateEncodingTestData(dateString: dateString,
                                         date: date,
                                         jsonData: jsonData,
                                         invalidJSONData: invalidJSONData)
        return value
    }
}
