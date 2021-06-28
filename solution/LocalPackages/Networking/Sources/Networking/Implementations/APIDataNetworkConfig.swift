//
//  APIDataNetworkConfig.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

/**
 Defines a type containing network configurations.
 */
public struct APIDataNetworkConfig: NetworkConfigurable {

    /// The base URL for the network service using this configuration.
    public let baseURL: URL

    /**
     Creates an instance of `APIDataNetworkConfig` with the given parameters.
     - Parameters:
        - baseURL: The base URL for the network service using this configuration.
     - Returns: An instance of `APIDataNetworkConfig`
     */
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
