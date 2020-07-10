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
enum Duration: Hashable {
    case seconds(TimeInterval)
    
    var timeInterval: TimeInterval {
        switch self {
        case .seconds(let duration):
            return duration
        }
    }
}
