//
//  Networker.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation

protocol NetworkerProtocol {
  func request<T: OutputDecodable>(_ request: Requestable, completion: ((Result<T, Error>) -> Void)?)
}

struct Networker: NetworkerProtocol {

  /// Default URL session for simple needs
  private let session: URLSession = URLSession(configuration: .default)

  /// Background queue for network operations
  private let queue = DispatchQueue(label: Constants.queue, qos: .userInitiated, attributes: .concurrent)

  /// Constants
  private struct Constants {
    static let queue = "NetworkerQueue"
    static let maxRetries = 1
  }

  /// Responsible for requesting any kind of ressource of type `Requestable`, with an `OutputDecodable` output
  /// Will primarily refresh the token if needed.
  ///
  /// - Parameters:
  ///   - request: the Requestable request to send
  ///   - completion: the completion block to execute once done
  func request<T: OutputDecodable>(_ request: Requestable, completion: ((Result<T, Error>) -> Void)?) {

    self.queue.async {
      self.send(request, completion: completion)
    }
  }

  /// Responsible for requesting any kind of ressource of type `Requestable`, with an `OutputDecodable` output
  /// Ensures the retry count hasn't exceeded before firing the request
  ///
  /// - Parameters:
  ///   - request: the Requestable request to send
  ///   - retryCount: the current number of times the request has been fired. Default value is `0`
  ///   - completion: the completion block to execute once done
  private func send<T: OutputDecodable>(_ request: Requestable, retryCount: Int = 0, completion: ((Result<T, Error>) -> Void)?) {

    print("Sending request \(request.path)")

    // Check the retry count first
    guard retryCount <= Constants.maxRetries else {
      DispatchQueue.main.async {
        print("Request \(request.path) failed with too many retries")
        completion?(.failure(Errors.tooManyRetries))
      }
      return
    }

    let task = self.session.dataTask(with: request.urlRequest) { data, response, error in
      let result: Result<T, Error>
      let statusCode = StatusCode(rawValue: (response as? HTTPURLResponse)?.statusCode)

      // Look for a specific error
      if let error = error {
        print("Request \(request.path) failed with error \(error)")
        result = .failure(error)
      }

      // Check any kind of status code that is not 200
      else if statusCode != .success {
        print("Request \(request.path) failed with status code \(statusCode)")
        result = .failure(Errors.serverError(statusCode.rawValue))
      }

      // Decode the response
      else if let data = data {
        do {
          result = .success(try T.decoded(data))
        } catch {
          print("Request \(request.path) failed to decode response with error \(error)")
          result = .failure(error)
        }
      } else {
        print("Request \(request.path) failed with no data")
        result = .failure(Errors.serverError(statusCode.rawValue))
      }

      // Call the completion block
      DispatchQueue.main.async {
        completion?(result)
      }
    }

    task.resume()
  }

  /// Enum holding status codes for all requests
  private enum StatusCode: Equatable {
    case success
    case unhandled(code: Int)

    init(rawValue: Int?) {
      switch rawValue {
      case 200: self = .success
      default: self = .unhandled(code: rawValue ?? -1)
      }
    }

    var rawValue: Int {
      switch self {
      case .success: return 200
      case .unhandled(let value): return value
      }
    }

    // MARK: Equatable

    static func == (lhs: StatusCode, rhs: StatusCode) -> Bool {
      switch (lhs, rhs) {
      case (.success, .success): return true
      case (.unhandled(let lCode), .unhandled(let rCode)): return lCode == rCode
      default: return false
      }
    }
  }

  /// Enum holding errors
  private enum Errors: Error {
    case tooManyRetries
    case serverError(Int)
  }
}
