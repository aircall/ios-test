//
//  CallStatusConverter.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation

enum CallStatusConverter {
    static func string(status: Call.Status) -> String {
        switch status {
        case .missed:
            return "missed call"
        case .voicemail:
            return "left a voicemail"
        case .answered:
            return "answered"
        }
    }
}
