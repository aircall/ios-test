//
//  CallType.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

/**
 Defines the type of call represented.
 */
public enum CallType: String {
    /// The call was missed by the user.
    case missed
    /// The call was answered by the user.
    case answered
    /// The call went to voice mail.
    case voicemail
}
