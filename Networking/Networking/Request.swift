//
//  Request.swift
//  Networking
//
//  Created by Patricio Guzman on 12/04/2021.
//

import Foundation

public enum Request {
    case calls
    case call(id: String)
    case updateCall(id: String)
    case reset

    var url: URL {
        baseURL.appendingPathComponent(path)
    }

    var path: String {
        switch self {
        case .calls:
            return "activities"

        case let .call(id),
             let .updateCall(id):
            return "activities/\(id)"

        case .reset:
            return "reset"
        }
    }

    private var baseURL: URL {
        URL(string: "https://aircall-job.herokuapp.com/")!
    }

    var method: String {
        switch self {
        case .calls,
             .call,
             .reset:
            return "get"

        case .updateCall:
            return "post"
        }
    }

    var body: Data? {
        switch self {
        case .calls,
             .call,
             .reset:
            return nil

        case .updateCall:
            let asdf: [String: Bool] = ["is_archived": true]
            return try! JSONEncoder().encode(asdf)
        }
    }

    var headers: [String: String] {
        switch self {
        case .updateCall:
            return ["Content-Type": "application/json"]
        case .call,
             .calls,
             .reset:
            return [:]
        }
    }

    func buildURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
