//
//  DefaultValueProvider.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

/**
 The type conforming to this protocol should provide a default value.
 */
public protocol DefaultValueProvider {
    /// The default value for this type.
    static var `default`: Self { get }
}
