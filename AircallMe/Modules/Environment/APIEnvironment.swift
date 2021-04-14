//
//  APIEnvironment.swift
//  Environment
//
//  Created by Rudy Frémont on 11/04/2021.
//

import Foundation

/// Struct to define all constant about the API to use
public struct API {
    
    public static var rootURL = URL(string: "https://aircall-job.herokuapp.com")!
    
    // In debug mode we define a wrong rootURL to test API request failure during UI Test
    #if DEBUG
    public struct FailureMode {
        public static var rootURL = URL(string: "https://www.example.com")!
    }
    #endif
}
