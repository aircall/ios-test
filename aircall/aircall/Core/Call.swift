//
//  Call.swift
//  aircall
//
//  Created by Patricio Guzman on 12/04/2021.
//

import Foundation

public struct Call: Decodable, Identifiable {
    public let id: Int
    let createdAt: String
    public let direction: Direction
    public let from: String
    public let to: String?
    public let airCallNumber: String
    let duration: String
    let type: `Type`

    private(set) var isArchived: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case direction
        case from
        case to
        case airCallNumber = "via"
        case duration
        case isArchived = "is_archived"
        case type = "call_type"
    }

    public enum Direction: String, Decodable {
        case inbound
        case outbound
    }

    enum `Type`: String, Decodable {
        case missed
        case answered
        case voicemail
    }

    mutating func archive() {
        isArchived = true
    }
}

public extension Call {
    init() {
        self.id = 1
        self.createdAt = "date"
        self.direction = .inbound
        self.from = "name"
        self.to = "number"
        self.airCallNumber = "numnber"
        self.duration = "duration"
        self.isArchived = false
        self.type = .answered
    }
}
