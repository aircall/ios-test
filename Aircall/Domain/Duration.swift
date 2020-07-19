//
//  Duration.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation

/// This allow to introduce other duration type and have explicit code about used unit
/// (i.e .seconds(30) is more explicit than just 30)
enum Duration: Codable, Hashable {
    case seconds(TimeInterval)
    
    var timeInterval: TimeInterval {
        switch self {
        case .seconds(let duration):
            return duration
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let value = Double(try container.decode(String.self)) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "string representation is not valid Double value")
        }
        
        self = .seconds(value)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .seconds(let time):
            try container.encode(String(time))
        }
    }
}
