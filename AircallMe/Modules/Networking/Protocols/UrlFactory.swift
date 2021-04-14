//
//  UrlFactory.swift
//  Networking
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation

/// Enum helper to declare REST method to indicate to the request manager
public enum RestMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

/// Protocol for an url request construction, each method is called to construct the request
public protocol UrlFactory {
    
    /// Return the URL for the request
    func url() -> URL
    
    /// Return the method for the request
    func method() -> RestMethod
    
    /// Return the query items for the request
    func queryItems() -> [URLQueryItem]?
    
    /// Return the body for the request
    func body() -> Data?
}

/// Extension for the protocol UrlFactory to provide default implementation
public extension UrlFactory {
 
    /// Default implementation for method
    func method() -> RestMethod {
        return .get
    }
    
    /// Default implementation for query item
    func queryItems() -> [URLQueryItem]? {
        return nil
    }
    
    /// Default implementation for body
    func body() -> Data? {
        return nil
    }
}
