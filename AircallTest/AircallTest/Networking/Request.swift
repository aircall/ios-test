//
//  Request.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 09/07/2021.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Request {
    var path: String
    var method: HTTPMethod
    var body: [String: Any]?
    
    init(path: String, method: HTTPMethod, body: [String: Any]? = nil) {
        self.path = path
        self.method = method
        self.body = body
    }
}

extension Request {
    private func getFormattedBody() -> Data? {
        guard let body = body,
              let formattedBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            return nil
        }
        return formattedBody
    }
    
    func getUrlRequest(base: String) -> URLRequest? {
        guard let url = URL(string: "https://\(base)\(path)") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        request.httpBody = getFormattedBody()
        return request
    }
}
