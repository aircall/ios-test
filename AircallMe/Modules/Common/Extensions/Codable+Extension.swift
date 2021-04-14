//
//  Codable+Extension.swift
//  Common
//
//  Created by Rudy Frémont on 11/04/2021.
//

import Foundation

/// Helpers to encode / decode with JSONEncoder / JSONDecoder

public extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Self.self, from: data)
    }
}

public extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}
