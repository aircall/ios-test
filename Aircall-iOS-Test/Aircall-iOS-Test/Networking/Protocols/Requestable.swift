//
//  Requestable.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation

/// Requests should conform to this protocol so that they can be used within the networker seamlessly
protocol Requestable {
  var path: String { get }
  var method: RequestMethod { get }

  var input: InputEncodable? { get set }
}

extension Requestable {

  /// Builds an `URLRequest` that will be fired by the `URLSession`
  var urlRequest: URLRequest {
    var components = URLComponents()
    components.scheme = Network.URL.scheme
    components.host = Network.URL.host
    components.path = self.path

    var urlRequest = URLRequest(url: components.url!)
    urlRequest.httpMethod = self.method.rawValue
    urlRequest.httpBody = try? self.input?.encoded()
    Network.httpHeaders.forEach {
      urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
    }

    return urlRequest
  }
}

