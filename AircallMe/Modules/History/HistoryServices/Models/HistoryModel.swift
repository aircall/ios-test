//
//  HistoryModel.swift
//  HistoryServices
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation
import Common

/// Definition for direction possible values
enum Direction: String, Codable {
    case inbound
    case outbound
}

/// Definition for call type possible values
enum CallType: String, Codable {
    case missed
    case answered
    case voicemail
}

/// Model that represent the retrieved data from the API
struct HistoryModel: Codable {
    let id: Int
    
    /// property wrapper to transform the received string in Date object
    @ISO8601DateFormatted var createdAt: Date?
    
    let direction: Direction
    let from: String
    let to: String?
    let via: String
    let duration: String
    let isArchived: Bool
    let callType: CallType

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case direction
        case from
        case to
        case via
        case duration
        case isArchived = "is_archived"
        case callType = "call_type"
    }
}
