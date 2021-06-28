//
//  RepositoryError.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Foundation

/**
 Described the types of errors performing actions with `DefaultCallsRepository`.
 */
public enum RepositoryError: Error {
    /// Failed to map to entity type.
    case failedEntityMapping
}
