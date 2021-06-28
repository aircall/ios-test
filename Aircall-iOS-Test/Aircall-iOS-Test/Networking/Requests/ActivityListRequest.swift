//
//  ActivityListRequest.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation

/// Activity list request
/// Get calls to display in the Activity Feed
///
struct ActivityListRequest: Requestable {

  var path: String = "/activities"
  var method: RequestMethod = .GET

  var input: InputEncodable?
  var queryItems: [String : String]?
}

// Request's output
typealias ActivityListOutput = [Activity]
extension ActivityListOutput: OutputDecodable {}
