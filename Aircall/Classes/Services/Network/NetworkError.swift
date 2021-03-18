//
//  NetworkError.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import Combine

/// Enum representing error type
enum NetworkError: Error {
  case unknown
  case invalidRequest
  case invalidResponse
  case dataError(statusCode: Int, data: Data)
  case parserError(reason: String)
}
