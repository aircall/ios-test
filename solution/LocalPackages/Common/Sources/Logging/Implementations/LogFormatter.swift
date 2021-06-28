//
//  LogFormatter.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

import Foundation

/**
 Formats log messages to make them more dev-friendly.
 */
open class LogFormatter: LogFormatterType {

    /// A `DateFormatter` to be provide a formatted string based on the date/time a message is logged.
    public let dateFormatter: DateFormatter

    /**
     Creates an instance of `LogFormatter` with the given `DateFormatter`.
     - Parameters:
        - dateFormatter: A `DateFormatter` to be provide a formatted string based on the date/time a message is logged.
     - Returns: An instance of `LogFormatter`
     */
    public init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }

    /**
     Formats a log message with the given parameters.
     - Remark: This class can be overriden to provide a different message format.
     - Parameters:
        - message: The message to be logged.
        - level: The log level the message represents.
        - date: The date/time in which the message was logged.
        - fileID: The name of the file and module in which it appears.
        - line: The line number on which it appears.
        - column: The column number in which it begins.
        - function: The name of the declaration in which it appears.
     */
    open func format(_ message: String,
                     level: LogLevel,
                     date: Date,
                     fileID: StaticString,
                     line: UInt,
                     column: UInt,
                     function: StaticString) -> String {
        let formattedDate = dateFormatter.string(from: date)
        let levelSymbol = symbol(for: level)
        return "\(formattedDate) - [\(fileID):\(function) (\(line):\(column))]: \(levelSymbol) \(message)"
    }

    /**
     Provides a special symbol for a given `LogLevel`.
     
     The default implementation provides the following symbols:
     - For *verbose* level: 🔬
     - For *debug* level: 💬
     - For *info* level: ℹ️
     - For *warning* level: ⚠️
     - For *error* level: ‼️
     
     For any other `LogLevel`, the symbol will be 👽.
     */
    open func symbol(for level: LogLevel) -> Character {
        switch level {
        case LogLevel.verbose: return "🔬"
        case LogLevel.debug: return "💬"
        case LogLevel.info: return "ℹ️"
        case LogLevel.warning: return "⚠️"
        case LogLevel.error: return "‼️"
        default: return "👽"
        }
    }
}
