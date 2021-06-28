//
//  JSONEncoderExtensions.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

public extension JSONEncoder {
    /**
     A `JSONEncoder` with a custom date encoding strategy using the full ISO 8601 standard.
     - Remark: An example of formated date would be like '2018-04-19T09:38:41.000Z'.
     */
    static var withFullISO8601Strategy: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(ISO8601DateFormatter.fullISO8601.string(from: date))
        }
        return encoder
    }
}
