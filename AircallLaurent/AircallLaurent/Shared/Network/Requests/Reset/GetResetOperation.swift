//
//  GetResetOperation.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import Foundation

//==============================================================================
// MARK: - Request
//==============================================================================

final class GetResetRequest: RequestProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var model: ResetModel?

  //----------------------------------------------------------------------------
  // MARK: - RequestProtocol implementation
  //----------------------------------------------------------------------------

  var endpoint: String {
    return "/reset"
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

final class GetResetOperation: NetworkOperation<ResetModel, GetResetRequest> {
  init(dependencies: [Operation]? = nil) {
    let request = GetResetRequest()
    super.init(request: request, dependencies: dependencies)
  }
}
