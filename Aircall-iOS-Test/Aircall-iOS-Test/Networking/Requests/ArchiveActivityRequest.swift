//
//  ArchiveActivityRequest.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation


/// Archive activity request
/// Update the archive state of a call
///
struct ArchiveActivityRequest: Requestable {

  var path: String = "/activities/:id"
  var method: RequestMethod = .POST

  var input: InputEncodable?
  var queryItems: [String : String]?

  /// Archive a given activity with its id
  /// Under the hood, it replaces the placeholder value in the path with the given id
  /// - Parameter id: the id to fetch the details of
  /// - Parameter input: the input. By default, it will archive the given activity passing a pre-configured
  /// input, but it can also be used to un-archive an activity
  init(id: Int, input: ArchiveActivityInput = ArchiveActivityInput(isArchived: true)) {
    self.path = self.path.replacingOccurrences(of: ":id", with: String(describing: id))
    self.input = input
  }
}

// Request's input
struct ArchiveActivityInput: InputEncodable {
  var isArchived: Bool
}
