//
//  LoggingTestData.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import Foundation

struct LoggingTestData {
    let message: String
    let date: Date
    let fileID: StaticString
    let line: UInt
    let column: UInt
    let function: StaticString
}

extension LoggingTestData: DefaultValueProvider {

    static var `default`: LoggingTestData {
        let message = "The truth is out there 👽"
        let date = Date(timeIntervalSince1970: TimeInterval(1624434641.9429832))
        let fileID: StaticString = #fileID
        let line: UInt = #line
        let column: UInt = #column
        let function: StaticString = #function
        let value = LoggingTestData(message: message, date: date, fileID: fileID, line: line, column: column, function: function)
        return value
    }
}
