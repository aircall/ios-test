//
//  LoggerTypeStub.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

@testable import Common
import Foundation

final class LoggerTypeStub: LoggerType {
    private(set) var formattedMessage: String?
    var level: LogLevel
    private let formatter: LogFormatterType

    init(level: LogLevel, formatter: LogFormatterType) {
        self.level = level
        self.formatter = formatter
    }

    func log(_ message: String, level: LogLevel, date: Date, fileID: StaticString, line: UInt, column: UInt, function: StaticString) -> Bool {
        guard self.level >= level else {
            return false
        }
        formattedMessage = formatter.format(message, level: level, date: date, fileID: fileID, line: line, column: column, function: function)
        return true
    }
}
