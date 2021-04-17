//
//  Session.swift
//  Networking
//
//  Created by Patricio Guzman on 12/04/2021.
//

import Combine

public class Session: SessionType {

    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func dataTaskPublisher(for request: Request) -> AnyPublisher<(), Error> {
        let urlRequest = request.buildURLRequest()

        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .mapError { $0 }
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    public func dataTaskPublisher<T>(for request: Request) -> AnyPublisher<T, Error> where T : Decodable {
        let urlRequest = request.buildURLRequest()
        let jsonDecoder = JSONDecoder()

        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
