//
//  LogLevel.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

import Foundation

/**
 `LogLevel` is associated with `UInt` since each should correspond to different levels of information.
 
 `LogLevel` can be extended to support other log levels.
 
 There are a few pre-defined `LogLevel`s:
 - `verbose` corresponds to `50` and is the level that allows the maximum amount of information to appear.
 -  `debug` corresponds to `40` and allows errors, warnings, info and debug messages to appear in the logs.
 - `info` corresponds to `30` and allows errors, warnings and info messages to appear in the logs.
 - `warning` corresponds to `20` and allows errors and warnings to appear in the logs.
 - `error` corresponds to `10` and allows only errors to appear in the logs.
 */
public typealias LogLevel = UInt

public extension LogLevel {
    /// Allows the maximum amount of information to appear in the logs.
    static let verbose: LogLevel = 50
    /// Allows errors, warnings, info and debug messages to appear in the logs.
    static let debug: LogLevel = 40
    /// Allows errors, warnings and info messages to appear in the logs.
    static let info: LogLevel = 30
    /// Allows errors and warnings to appear in the logs.
    static let warning: LogLevel = 20
    /// Allows only errors to appear in the logs.
    static let error: LogLevel = 10
}
