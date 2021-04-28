//
//  GetCallsOperation.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

//==============================================================================
// MARK: - Request
//==============================================================================

final class GetCallsRequest: RequestProtocol {

  var model: CallModel?

  //----------------------------------------------------------------------------
  // MARK: - RequestProtocol implementation
  //----------------------------------------------------------------------------

  var endpoint: String {
    return "/activities"
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

final class GetCallsOperation: NetworkOperation<[CallModel], GetCallsRequest> {
  init(dependencies: [Operation]? = nil) {
    let request = GetCallsRequest()
    super.init(request: request, dependencies: dependencies)
  }
}
