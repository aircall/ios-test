//
//  InputEncodable.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation

/// Protocol that makes the encoder encoding each key to snake case, and dates to server supported format
/// Should be used for all request inputs
protocol InputEncodable: Codable {
  func encoded() throws -> Data
}

extension InputEncodable {
  func encoded() throws -> Data {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    encoder.dateEncodingStrategy = .customISO8601
    return try encoder.encode(self)
  }
}

/// Support the date encoding strategy by using our iso 8601 formatter
private extension JSONEncoder.DateEncodingStrategy {
  static let customISO8601 = custom {
    var container = $1.singleValueContainer()
    try container.encode(Formatters.shared.iso8601DateFormatter.string(from: $0))
  }
}

