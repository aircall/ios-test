//
//  DefaultNetworkService.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import Common
import Foundation

/**
 The default implementation of the `NetworkService`.
 */
final public class DefaultNetworkService: NetworkService {

    private let session: NetworkSession
    private let config: NetworkConfigurable

    /**
     Creates an instance of `DefaultNetworkService` with the given parameters.
     - Parameters:
        - session: An instance of `NetworkSession`.
        - session: A network configuration (`NetworkConfigurable`).
     - Returns: An instance of `DefaultNetworkService`
     */
    public init(session: NetworkSession,
                config: NetworkConfigurable) {
        self.session = session
        self.config = config
    }

    /**
     Executes a request to a given endpoint
     - Parameters:
        - endpoint: The endpoint to send the request to.
        - completion: A closure to be executed uppon completion.
     - Returns: An instance of `Cancellable` if the task can be cancelled.
     */
    public func request(endpoint: Requestable, completion: @escaping (Result<Data?, NetworkError>) -> Void) -> Cancellable? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(NetworkError.urlGeneration))
            return nil
        }
    }

    private func request(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) -> Cancellable {

        let sessionDataTask = session.loadData(from: request) { data, response, requestError in
            var error: NetworkError
            if let requestError = requestError {

                if let response = response as? HTTPURLResponse,
                   (400..<600).contains(response.statusCode) {
                    error = .errorStatusCode(response.statusCode)
                    Log.shared.log("HTTP status code: \(response.statusCode)", level: .verbose)
                } else if (requestError as NSError).code == NSURLErrorNotConnectedToInternet {
                    error = .notConnected
                } else if (requestError as NSError).code == NSURLErrorCancelled {
                    error = .cancelled
                } else {
                    error = .underlyingError(requestError)
                }
                Log.shared.log("Request error: \(requestError)", level: .error)

                completion(.failure(error))
            } else {
                Log.shared.log("Response data: \(data?.formattedResponseLog ?? CommonConstants.emptyString)", level: .verbose)
                completion(.success(data))
            }
        }

        Log.shared.log("Request: \(request.formattedLog)", level: .verbose)
        return sessionDataTask
    }
}

extension URLRequest {
    var formattedLog: String {
        var message = String(describing: url)
            + "headers: \(String(describing: allHTTPHeaderFields))\n"
            + "method: \(String(describing: httpMethod))\n"
        if let httpBody = httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {
            message += "body: \(bodyString)"
        }
        return message
    }
}

extension Data {
    var formattedResponseLog: String {
        guard let dataDict =  try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
            return CommonConstants.emptyString
        }
        return String(describing: dataDict)
    }
}
