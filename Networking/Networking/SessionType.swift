//
//  SessionType.swift
//  Networking
//
//  Created by Patricio Guzman on 12/04/2021.
//

import Combine

public protocol SessionType {
    func dataTaskPublisher(for request: Request) -> AnyPublisher<(), Error>
    func dataTaskPublisher<T: Decodable>(for request: Request) -> AnyPublisher<T, Error>
}

// to remove
public class SessionForPreview: SessionType {

    public init() {
    }

    public func dataTaskPublisher(for request: Request) -> AnyPublisher<(), Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func dataTaskPublisher<T>(for request: Request) -> AnyPublisher<T, Error> where T : Decodable {
        Just(Data())
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
