//
//  LogError.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

/**
 Represents error related to Logging.
 */
public enum LogError: Error {
    /// The `Log.setupLoggers()` was already called.
    case loggersAlreadySetup
}
