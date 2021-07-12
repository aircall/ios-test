//
//  Activities.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

typealias Activities = [Activity]

// MARK: - Activity
struct Activity: Decodable, Identifiable {
    let id: Int
    let createdAt: Date
    let direction: Direction
    let from: String
    let to: String?
    let via, duration: String
    let isArchived: Bool
    let callType: CallType
    
    enum Direction: String, Decodable {
        case inbound, outbound
    }
    
    enum CallType: String, Decodable {
        case missed, answered, voicemail
    }
}

