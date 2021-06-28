//
//  ISO8601DateFormatterExtensions.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

public extension ISO8601DateFormatter {
    /**
     A `ISO8601DateFormatter` that handles dates using the full ISO 8601 standard.
     - Remark: An example of formated date would be like '2018-04-19T09:38:41.000Z'.
     */
    static var fullISO8601: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withFullTime, .withTimeZone, .withFractionalSeconds]
        return formatter
    }
}
