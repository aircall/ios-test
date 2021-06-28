//
//  NetworkerMock.swift
//  Aircall-iOS-TestTests
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import Foundation
@testable import Aircall_iOS_Test

enum NetworkerMockError: Error {
  case error
}

class NetworkerMock: NetworkerProtocol {

  typealias MockedResult = (path: String, data: Data?)
  private var results: [MockedResult]

  init(results: [MockedResult] = []) {
    self.results = results
  }

  func request<T>(_ request: Requestable, completion: ((Result<T, Error>) -> Void)?) where T : OutputDecodable {
    let matchingMockIndex = self.results.firstIndex(where: { $0.path == request.path })
    if let index = matchingMockIndex, let data = self.results[index].data {
      completion?(.success(try! T.decoded(data)))
      self.results.remove(at: index)
    } else {
      completion?(.failure(NetworkerMockError.error))
    }
  }


}
