//
//  ISO8601DateFormatted.swift
//  Common
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation

/// Property wrapper to manage date with iso8601 format (with Internet date / time and fractional seconds)
@propertyWrapper
public struct ISO8601DateFormatted {

    public let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    public var wrappedValue: Date?
    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
    }
}

/// Extension to encode / decode the property wrapper
extension ISO8601DateFormatted: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            wrappedValue = nil
        } else {
            let value = try container.decode(String.self)
            wrappedValue = dateFormatter.date(from: value)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let wrappedValue = wrappedValue {
            try container.encode(dateFormatter.string(from: wrappedValue))
        } else {
            try container.encodeNil()
        }
    }
}
