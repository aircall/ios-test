//
//  JSONDecoderExtensions.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

public extension JSONDecoder {
    /**
     A `JSONDecoder` with a custom date decoding strategy using the full ISO 8601 standard.
     - Remark: An example of formated date would be like '2018-04-19T09:38:41.000Z'.
     */
    static var withFullISO8601Strategy: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            guard let date = ISO8601DateFormatter.fullISO8601.date(from: string) else {
                let description = "Date format is not supported: \(string)"
                throw DecodingError.dataCorruptedError(in: container,
                                                       debugDescription: description)
            }
            return date
        }
        return decoder
    }
}
