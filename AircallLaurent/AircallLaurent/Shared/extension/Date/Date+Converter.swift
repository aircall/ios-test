//
//  Date+Converter.swift
//  AircallLaurent
//
//  Created by Laurent on 26/04/2021.
//

import Foundation

extension Date {

  init?(fromISO8601 iso8601Date: String) {
    // TODO: Localize day and time. Out of scope for this test.
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
    guard let date = dateFormatter.date(from: iso8601Date) else {
      return nil
    }
    self = date
  }

  var timeIn24HourFormat: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: self)
  }

  var monthDayShortFormat: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.dateFormat = "MMM. dd"
    return formatter.string(from: self)
  }

}
