//
//  ActivityDetailRequest.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation

/// Activity detail request
/// Retrieve a specific call details
///
struct ActivityDetailRequest: Requestable {

  var path: String = "/activities/:id"
  var method: RequestMethod = .GET

  var input: InputEncodable?
  var queryItems: [String : String]?

  /// Fetch the detail of a request with its id
  /// Under the hood, it replaces the placeholder value in the path with the given id
  /// - Parameter id: the id to fetch the details of
  init(id: Int) {
    self.path = self.path.replacingOccurrences(of: ":id", with: String(describing: id))
  }
}
