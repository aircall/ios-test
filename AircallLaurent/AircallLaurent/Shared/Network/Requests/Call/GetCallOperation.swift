//
//  GetCallOperation.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

//==============================================================================
// MARK: - Request
//==============================================================================

final class GetCallRequest: RequestProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var model: CallModel?

  /// Request properties
  var id: Int

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(id: Int) {
    self.id = id
  }

  //----------------------------------------------------------------------------
  // MARK: - RequestProtocol implementation
  //----------------------------------------------------------------------------

  var endpoint: String {
    return "/activities/\(id)"
  }

  var method: HTTPMethod {
    return .get
  }

  var queryType: QueryType {
    return .url
  }

  var tokenType: TokenType {
    return .none
  }

  //----------------------------------------------------------------------------
  // MARK: - Parameters
  //----------------------------------------------------------------------------

  var parameters: [String: Any]?
}

//==============================================================================
// MARK: - Operation
//==============================================================================

final class GetCallOperation: NetworkOperation<CallModel, GetCallRequest> {
  init(id: Int, dependencies: [Operation]? = nil) {
    let request = GetCallRequest(id: id)
    super.init(request: request, dependencies: dependencies)
  }
}
