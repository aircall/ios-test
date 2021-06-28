//
//  UnifiedLogger.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

import Foundation
import os.log

/**
 An implementation of `LoggerType` which uses the [Unified Logging System](https://developer.apple.com/documentation/os/logging).
 */
@available(iOS 10.0, macOS 10.12, *)
open class UnifiedLogger: LoggerType {

    /// The lowest supported `LogLevel`. All messages with level lower than this will be ignored.
    var level: LogLevel

    /// An instance of `LogFormatterType` used to format the messages to a specific standard.
    private let formatter: LogFormatterType

    /**
     Creates an instance of `UnifiedLogger` with the given `LogLevel` and `LogFormatterType`.
     - Parameters:
        - level: The lowest supported `LogLevel`. All messages with level lower than this will be ignored.
        - formatter: An instance of `LogFormatterType` used to format the messages to a specific standard.
     - Returns: An instance of `Log`
     */
    init(level: LogLevel, formatter: LogFormatterType) {
        self.level = level
        self.formatter = formatter
    }

    /**
     Logs a message to the *Unified Logging System* if the `LogLevel` is supported.
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
    open func log(_ message: String,
                  level: LogLevel,
                  date: Date,
                  fileID: StaticString,
                  line: UInt,
                  column: UInt,
                  function: StaticString) -> Bool {
        guard self.level >= level else {
            return false
        }
        let formattedMessage = formatter.format(message, level: level, date: date, fileID: fileID, line: line, column: column, function: function)
        os_log("%@", formattedMessage)
        return true
    }
}
