//
//  LogFormatterType.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

import Foundation

/**
 Defines a *Log formatter*, which can be used to standardize the log messages.
 */
public protocol LogFormatterType {
    /**
     Formats a log message with the given parameters.
     - Parameters:
        - message: The message to be logged.
        - level: The log level the message represents.
        - date: The date/time in which the message was logged.
        - fileID: The name of the file and module in which it appears.
        - line: The line number on which it appears.
        - column: The column number in which it begins.
        - function: The name of the declaration in which it appears.
     */
    func format(_ message: String, level: LogLevel, date: Date, fileID: StaticString, line: UInt, column: UInt, function: StaticString) -> String
}
