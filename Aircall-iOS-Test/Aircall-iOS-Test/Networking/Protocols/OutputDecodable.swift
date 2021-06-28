//
//  OutputDecodable.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation

/// Protocol that makes the decoder decoding each key from snake case, and dates from server supported format
/// Should be used for all request outputs
protocol OutputDecodable: Codable {
  static func decoded<T: Codable>(_ data: Data) throws -> T
}

extension OutputDecodable {
  static func decoded<T: Codable>(_ data: Data) throws -> T {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .customISO8601
    return try decoder.decode(T.self, from: data)
  }
}

/// Support the date decoding strategy by using our iso 8601 formatter
private extension JSONDecoder.DateDecodingStrategy {
  static let customISO8601 = custom {
    let container = try $0.singleValueContainer()
    let string = try container.decode(String.self)
    if let date = Formatters.shared.iso8601DateFormatter.date(from: string) {
      return date
    }
    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
  }
}
