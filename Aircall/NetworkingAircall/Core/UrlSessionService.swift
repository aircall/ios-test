//
//  UrlSessionService.swift
//  NetworkingAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import Foundation

enum NetworkingError: Error {
    case serverError(Error)
    case invalidDataResponse
    case invalidStatusCode
}

public protocol ServerService {
    func performRequest(_ request: URLRequestable, completion: @escaping (Result<Data, Error>) -> Void)
}

public class UrlSessionService: ServerService {

    private let session: URLSession
    
    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func performRequest(_ request: URLRequestable, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: request.asURLRequest()) { (data, response, error) in
            let result: Result<Data, Error>
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard error == nil else {
                return result = .failure(NetworkingError.serverError(error!))
            }
            if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                guard let data = data else { return result = .failure(NetworkingError.invalidDataResponse) }
                result = .success(data)
            } else {
                result = .failure(NetworkingError.invalidStatusCode)
            }
        }.resume()
    }
}
