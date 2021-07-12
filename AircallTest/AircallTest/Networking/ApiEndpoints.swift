//
//  ApiEndpoints.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

public enum ApiEndpoint {
    case activities
    case activity(id: Int)
    case archiveActivity(id: Int, body: [String: Any])
}

extension ApiEndpoint {
    var request: Request? {
        switch self {
        case .activities:
            return Request(path: "/activities", method: .get)
        case .activity(id: let id):
            return Request(path: "/activities/\(id)", method: .get)
        case .archiveActivity(id: let id, let body):
            return Request(path: "/activities/\(id)", method: .post, body: body)
        }
    }
}
