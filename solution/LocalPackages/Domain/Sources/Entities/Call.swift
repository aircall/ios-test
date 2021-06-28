//
//  Call.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

/**
 Entity which stores information related to a call.
 */
public struct Call: Equatable {
    /// The unique ID of the call.
    public let id: UInt
    /// The creation date.
    public let createdAt: Date
    /// The direction of the call - *inbound* or *outbound* call.
    public let direction: CallDirection
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
    public let type: CallType

    /**
     Creates an instance of `Call` with the given parameters.
     - Parameters:
        - id: The unique ID of the call.
        - createdAt: The creation date.
        - direction: The direction of the call - *inbound* or *outbound* call.
        - from: The caller's number.
        - to: The callee's number.
        - via: Aircall number used for the call
        - duration: The duration of a call (in seconds)
        - isArchived: Tells whether the call is archived or not.
        - type: The type of the call - can be a *missed*, *answered* or *voicemail*.
     - Returns: An instance of `Call`
     */
    public init(id: UInt,
                createdAt: Date,
                direction: CallDirection,
                from: String,
                to: String?,
                via: String,
                duration: String,
                isArchived: Bool,
                type: CallType) {
        self.id = id
        self.createdAt = createdAt
        self.direction = direction
        self.from = from
        self.to = to
        self.via = via
        self.duration = duration
        self.isArchived = isArchived
        self.type = type
    }
}
