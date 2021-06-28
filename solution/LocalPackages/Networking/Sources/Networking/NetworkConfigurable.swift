//
//  NetworkConfigurable.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 Defines a type containing network configurations.
 */
public protocol NetworkConfigurable {
    /// The base URL for the network service using this configuration.
    var baseURL: URL { get }
}
