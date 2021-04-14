//
//  Date+Extension.swift
//  Common
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation

/// Helper extension to get specific date / time format string
public extension Date {
    
    /// Return a string with short month and day indication only
    /// - Returns: formatted date string
    func dayMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMdd")
        return dateFormatter.string(from: self)
    }
    
    /// Return a string with localized time indication
    /// - Returns: formatted time string
    func timeShort() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
