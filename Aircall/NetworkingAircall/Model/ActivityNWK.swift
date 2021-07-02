//
//  ActivityNWK.swift
//  NetworkingAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

public struct ActivityNWK: Codable {
    
    public let id: Int
    public let creationDate: String
    public let direction: String
    public let from: String
    public let to: String?
    public let via: String
    public let duration: String
    public let isArchived: Bool
    public let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case creationDate = "created_at"
        case direction
        case from
        case to
        case via
        case duration
        case isArchived = "is_archived"
        case type = "call_type"
    }
}

extension ActivityNWK {

    public init(id: Int,
                creationDate: String,
                direction: String,
                from: String,
                to: String,
                via: String,
                duration: String,
                isArchived: Bool,
                type: String) {
        self.id = id
        self.creationDate = creationDate
        self.direction = direction
        self.from = from
        self.to = to
        self.via = via
        self.duration = duration
        self.isArchived = isArchived
        self.type = type
    }
}
