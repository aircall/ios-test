//
//  EndPoint.swift
//  NetworkingAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import Foundation

public protocol URLRequestable {
    func asURLRequest() -> URLRequest
}

public enum EndPoint: URLRequestable {
      
    case getActivities
    case archiveActivity(id: Int)
    case reset
    
    public func asURLRequest() -> URLRequest {
        var scheme: String {
            switch self {
            case .getActivities, .archiveActivity, .reset:
                return "https"
            }
        }
        
        var host: String {
            switch self {
            case .getActivities, .archiveActivity, .reset:
                return "aircall-job.herokuapp.com"
            }
        }
        
        var path: String {
            switch self {
            case .getActivities:
                return "/activities"
            case .archiveActivity(let id):
                return "/activities/\(id)"
            case .reset:
                return "/reset"
            }
        }
        
        var method: String {
            switch self {
            case .getActivities, .reset:
                return "GET"
            case .archiveActivity:
                return "POST"
            }
        }
        
        var queryItems: [URLQueryItem]? {
            switch self {
            case .getActivities, .archiveActivity, .reset:
                return nil
            }
        }
        
        var body: Data? {
            switch self {
            case .getActivities, .reset:
                return nil
            case .archiveActivity(let id):
                return buildArchiveActivityBody(id: id)
            }
        }
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Failed to construct URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}

// MARK: - Private methods
extension EndPoint {
    
    private func buildArchiveActivityBody(id: Int) -> Data? {
        let bodyJson: [String: Bool] = [
            "is_archived": true
        ]
        return try? JSONSerialization.data(withJSONObject: bodyJson)
    }
}
