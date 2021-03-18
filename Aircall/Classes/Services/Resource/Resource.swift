//
//  Ressource.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation

struct Resource<T: Decodable> {
  private let url: URL
  private let method: HTTPMethod
  private let params: [String: CustomStringConvertible]
  private let body: [String: Any]
  private let header: [String:String] = [:]

  var request: URLRequest? {
    guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }

    if !params.isEmpty {
      components.queryItems = params.keys.map({ key  in
        URLQueryItem(name: key, value: params[key]?.description)
      })
    }

    guard let url = components.url else { return nil }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    if !body.isEmpty {
      do {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
      } catch {
        return nil
      }
    }

    return urlRequest
  }

  init(url: URL, method: HTTPMethod = .get, params: [String: CustomStringConvertible] = [:], body: [String: Any] = [:]) {
    self.url = url
    self.method = method
    self.params = params
    self.body = body
  }
}
