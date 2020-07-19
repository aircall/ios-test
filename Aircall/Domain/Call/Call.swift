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

struct Call: Identifiable, Codable, Hashable {
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
    enum Direction: String, Codable, Hashable {
        case inbound
        case outbound
    }
    
    enum Status: String, Codable, Hashable {
        case missed
        case answered
        case voicemail
    }
}

enum Caller: Codable, Hashable {
    case phone(PhoneNumber)
    case contact(String)
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        let hasLetters = value.unicodeScalars.contains(where: CharacterSet.letters.contains)
        
        self = hasLetters ? .contact(value) : .phone(value)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .phone(let number):
            try container.encode(number)
        case .contact(let name):
            try container.encode(name)
        }
    }
}
