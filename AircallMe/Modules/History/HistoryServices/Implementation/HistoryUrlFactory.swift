//
//  HistoryUrlFactory.swift
//  HistoryServices
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation
import Networking
import Environment

/// UrlFactory for history services - the enum declare each request by a case
enum HistoryUrlFactory: UrlFactory {
    
    case list
    case detail(identifier: Int)
    case archive(identifier: Int)
    case reset

    #if DEBUG
    /// In debug mode we can activate a specific mode to change the rootUrl and have failed request (for UI Test in failure case)
    static let rootURL = ProcessInfo.processInfo.arguments.contains("failure-mode") ? Environment.API.FailureMode.rootURL : Environment.API.rootURL
    #else
    static let rootURL = Environment.API.rootURL
    #endif

    /// Specific keywords for url construction
    static let activities = "activities"
    static let resetCommand = "reset"
    
    func url() -> URL {
        let urlRoot = Self.rootURL.appendingPathComponent(Self.activities)
        switch self {
        case .detail(let identifier):
            return urlRoot.appendingPathComponent(String(identifier))
        case .archive(let identifier):
            return urlRoot.appendingPathComponent(String(identifier))
        case .reset:
            return Self.rootURL.appendingPathComponent(Self.resetCommand)
        default:
            return urlRoot
        }
    }
    
    func method() -> RestMethod {
        switch self {
        case .archive:
            return .post
        default:
            return .get
        }
    }
    
    func body() -> Data? {
        switch self {
        case .archive:
           return try? ["is_archived": true].encode()
        default:
            return nil
        }
    }
}
