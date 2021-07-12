//
//  Date+DateFormatter.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

enum DateFormat: String {
    case hourAndMinutes = "HH:mm"
    case dayAndMonth = "dd/MM"
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
}

extension Date {
    func string(withFormat format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        return formatter.string(from: self)
    }
}

extension DateFormatter {
  static let iso8601: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = DateFormat.iso8601.rawValue
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = Calendar.current.timeZone
    formatter.locale = Calendar.current.locale
    return formatter
  }()
}

