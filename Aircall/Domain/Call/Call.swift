//
//  Call.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation

/// In real-app we would parse and make a data struct instead of String to access phone number info
/// (like international code) and custom format
typealias PhoneNumber = String

struct Call: Identifiable, Hashable {
    let id: Int
    let createdAt: Date
    let direction: Direction
    let from: Caller
    let to: Caller?
    let via: String
    let duration: Duration
    let isArchived: Bool
    let callType: Status
}

extension Call {
    enum Direction: String, Hashable {
        case inbound
        case outbound
    }
    
    enum Status: String, Hashable {
        case missed
        case answered
        case voicemail
    }
}

enum Caller: Hashable {
    case phone(PhoneNumber)
    case contact(String)
}
