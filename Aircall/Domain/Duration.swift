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
        self = try .seconds(decoder.singleValueContainer().decode(TimeInterval.self))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .seconds(let time):
            try container.encode(time)
        }
    }
}
