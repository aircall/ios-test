//
//  CallResponse.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 Entity which stores information related to a call.
 */
public struct CallResponse: Codable, Equatable {
    /// The unique ID of the call.
    public let id: UInt
    /// The creation date.
    public let createdAt: Date
    /// The direction of the call - *inbound* or *outbound* call.
    public let direction: CallDirectionResponse
    /// The caller's number.
    public let from: String
    /// The callee's number.
    public let to: String?
    /// Aircall number used for the call
    public let via: String
    /// The duration of a call (in seconds)
    public let duration: String
    /// Tells whether the call is archived or not.
    public let isArchived: Bool
    /// The type of the call - can be a *missed*, *answered* or *voicemail*.
    public let type: CallTypeResponse

    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case direction
        case from
        case to
        case via
        case duration
        case isArchived = "is_archived"
        case type = "call_type"
    }
}
