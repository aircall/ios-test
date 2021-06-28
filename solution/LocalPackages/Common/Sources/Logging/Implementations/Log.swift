//
//  Log.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

import Foundation

/**
 Logs messages to several `LoggerType`s.
 - Remark: This helps in case it's needed to log messages not only to the console, but also to other services (crash reports, data base, etc.)
 */
final public class Log {

    /// The default `DispatchQueue` used to log all the messages asynchronoulsy.
    public static let defaultQueue = DispatchQueue(label: "io.codespark.Aircall.Common.Logging.Log")

    /// An array of `LoggerType` to use to log messages to multiple loggers.
    public private(set) var loggers: [LoggerType]?

    /// The `DispatchQueue` to be used to log the messages to multiple logs asynchronoulsy.
    internal let queue: DispatchQueue

    /// A shared instance of `Log` created with the `Log.defaultQueue`.
    public private(set) static var shared = Log(queue: defaultQueue)

    /**
     Creates an instance of `Log` with the given `DispatchQueue`.
     - Parameters:
        - queue: A `DispatchQueue` to log the messages to multiple logs asynchronoulsy.
     - Returns: An instance of `Log`
     */
    public init(queue: DispatchQueue = defaultQueue) {
        self.queue = queue
    }

    /**
     Set the collection of loggers to log the messages to.
     - Parameters:
        - loggers: An array of `LoggerType` to log the messages to.
     - Remark: This can only be called once and is ideally called during the application startup alongside other configuration or setup tasks.
     Doing this as early as possible will ensure consistency and that all messages get logged.
     */
    public func setupLoggers(_ loggers: [LoggerType]) throws {
        guard self.loggers == nil else {
            throw LogError.loggersAlreadySetup
        }
        self.loggers = loggers
    }

    /**
     Logs a message with the given `LogLevel`.
     - Remark: All other parameters are set by default corresponding the place at the log was called.
     No messages will be logged if until `setupLoggers` is called.
     - Parameters:
        - message: The message to be logged.
        - level: The log level the message represents.
        - fileID: The name of the file and module in which it appears.
        - line: The line number on which it appears.
        - column: The column number in which it begins.
        - function: The name of the declaration in which it appears.
        - completion: A closure to be executed when log finishes.
     */
    public func log(_ message: String,
                    level: LogLevel,
                    fileID: StaticString = #fileID,
                    line: UInt = #line,
                    column: UInt = #column,
                    function: StaticString = #function,
                    completion: (() -> Void)? = nil) {

        guard let loggers = loggers else {
            completion?()
            return
        }
        let date = Date()
        let group = DispatchGroup() // We will wait for each logger before calling completion
        for logger in loggers {
            group.enter() // Call for each logger
            queue.async {
                logger.log(message, level: level, date: date, fileID: fileID, line: line, column: column, function: function)
                group.leave() // Call after each logging with each logger
            }
        }
        group.wait() // Wait till the calls to enter()/leave() are balanced, then call completion
        completion?()
    }
}
