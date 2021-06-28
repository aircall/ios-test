//
//  CallArchivingRequest.swift
//  
//
//  Created by Jobert on 27/06/2021.
//

import Foundation

/**
 The body structure for a request  to (un)archive a call.
 */
public struct CallArchivingRequest: Codable, Equatable {
    /// Tells whether the call is archived or not.
    public let isArchived: Bool

    private enum CodingKeys: String, CodingKey {
        case isArchived = "is_archived"
    }
}
