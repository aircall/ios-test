//
//  PostCallOperation.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

//==============================================================================
// MARK: - Request
//==============================================================================

final class PostCallRequest: RequestProtocol {

  var model: CallModel?

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private let id: Int

  /// Init with request properties
  ///
  /// - Parameter search: query
  init(call: CallModel) {
    self.model = call
    self.id = call.id
  }

  //----------------------------------------------------------------------------
  // MARK: - RequestProtocol implementation
  //----------------------------------------------------------------------------

  var endpoint: String {
    return "/activities/\(id)"
  }

  var method: HTTPMethod {
    return .post
  }

  var queryType: QueryType {
    return .url
  }

  var parameters: [String: Any]? {
    return model?.dictionary
  }

  var tokenType: TokenType {
    return .none
  }
}

//==============================================================================
// MARK: - Operation
//==============================================================================

final class PostCallOperation: NetworkOperation<CallModel, PostCallRequest> {
  init(call: CallModel, dependencies: [Operation]? = nil) {
    let request = PostCallRequest(call: call)
    super.init(request: request, dependencies: dependencies)
  }
}

