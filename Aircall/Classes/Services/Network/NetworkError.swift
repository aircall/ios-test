//
//  NetworkError.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import Combine

enum NetworkError: Error {
  case unknown
  case invalidRequest
  case invalidResponse
  case apiError(reason: String)
  case dataError(statusCode: Int, data: Data)
  case parserError(reason: String)
}
