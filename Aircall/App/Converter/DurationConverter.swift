//
//  DurationConverter.swift
//  Aircall
//
//  Created by JC on 10/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation

enum DurationConverter {
    static func string(duration: Duration) -> String? {
        let formatter = DateComponentsFormatter()
        
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.dropLeading, .dropTrailing]
        
        return formatter.string(from: duration.timeInterval)
    }
}
