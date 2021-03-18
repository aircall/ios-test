//
//  NetworkManager.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import Combine

struct NetworkManager {

  typealias Handler<T> = AnyPublisher<Result<T, NetworkError>, Never>

  func request<T: Decodable>(_ resource: Resource<T>) -> AnyPublisher<Result<T, NetworkError>, Never> {
    guard let request = resource.request else { return .just(.failure(NetworkError.invalidRequest)) }

    return URLSession.shared.dataTaskPublisher(for: request)
      .mapError { error in NetworkError.parserError(reason: error.localizedDescription) }
      .flatMap { data, response -> AnyPublisher<Data, Error> in
        guard let httpResponse = response as? HTTPURLResponse else { return .fail(NetworkError.invalidResponse) }
        guard 200..<300 ~= httpResponse.statusCode else { return .fail(NetworkError.dataError(statusCode: httpResponse.statusCode, data: data)) }

        return .just(data)
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .map { .success($0) }
      .catch ({ error -> AnyPublisher<Result<T, NetworkError>, Never> in
        return .just(.failure(NetworkError.invalidRequest))
      })
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

}

