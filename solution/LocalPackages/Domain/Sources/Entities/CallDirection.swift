//
//  CallDirection.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

/**
 The direction of the call (from the user's point of view).
 */
public enum CallDirection: String {
    /// The call is inbound - the user was being called.
    case inbound
    /// The call is outbound - the user was calling.
    case outbound
}
