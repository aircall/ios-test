//
//  LoggerType.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

import Foundation

/**
 Defines a type of *Logger* to log messages to.
 - Remark: The Logger should handle the level of the messages logged and provide its own support to format the messages with the given parameters.
 */
public protocol LoggerType {
    /**
     Logs a message with the given `LogLevel`.
     - Parameters:
        - message: The message to be logged.
        - level: The log level the message represents.
        - date: The date/time in which the message was logged.
        - fileID: The name of the file and module in which it appears.
        - line: The line number on which it appears.
        - column: The column number in which it begins.
        - function: The name of the declaration in which it appears.
     - Returns: `true` if the message was logged, otherwise `false`.
     */
    @discardableResult
    func log(_ message: String,
             level: LogLevel,
             date: Date,
             fileID: StaticString,
             line: UInt,
             column: UInt,
             function: StaticString) -> Bool
}
