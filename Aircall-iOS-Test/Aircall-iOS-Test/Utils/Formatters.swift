//
//  Formatters.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import Foundation

/// Let's try to keep it smooth, and create formatters once, and when needed.
class Formatters {

  static let shared = Formatters()

  lazy var iso8601DateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions =  [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withFractionalSeconds]
    return formatter
  }()

  lazy var shortDateTimeFormatter: DateFormatter = {
    let format = DateFormatter.dateFormat(fromTemplate: "MMM d HH:mm", options: 0, locale: .current)
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter
  }()

  lazy var longDateTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .long
    return formatter
  }()

  lazy var dateComponentsFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = .brief
    return formatter
  }()
}
