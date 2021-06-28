//
//  ResetActivitiesRequest.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation

/// Reset activities request
/// Reset all calls to their initial state
///
struct ResetActivitiesRequest: Requestable {

  var path: String = "/reset"
  var method: RequestMethod = .GET

  var input: InputEncodable?
  var queryItems: [String : String]?
}

// Request's output
struct ResetActivitiesOutput: OutputDecodable {
  var message: String
}
