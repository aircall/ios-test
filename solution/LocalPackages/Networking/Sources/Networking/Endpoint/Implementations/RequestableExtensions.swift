//
//  File.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Foundation

extension Requestable {
    /**
     Creates an instance of `URLRequest` for the instance with the given configuration.
     - Parameters: A network configuration (`NetworkConfigurable`).
     - Returns: An instance of `URLRequest`.
     - Throws: `RequestError.failedRequestCreation` if the request could not be created.
     */
    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try url(with: config)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = body
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return urlRequest
    }

    private func url(with config: NetworkConfigurable) throws -> URL {
        let endpoint = config.baseURL.absoluteString.appending(path)
        guard let urlComponents = URLComponents(string: endpoint),
              let url = urlComponents.url else {
            throw RequestError.failedRequestCreation
        }
        return url
    }
}
