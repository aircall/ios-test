//
//  CallDirectionResponse.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 The direction of the call (from the user's point of view).
 */
public enum CallDirectionResponse: String, Codable {
    /// The call is inbound - the user was being called.
    case inbound
    /// The call is outbound - the user was calling.
    case outbound
}
