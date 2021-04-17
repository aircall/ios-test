//
//  SessionMock.swift
//  Networking
//
//  Created by Patricio Guzman on 12/04/2021.
//

import Combine
import Networking

public class SessionMock: SessionType {


    public var responsePathForRequest: ((Request) -> String)?

    public init() {
    }

    public func dataTaskPublisher(for request: Request) -> AnyPublisher<(), Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func dataTaskPublisher<T>(for request: Request) -> AnyPublisher<T, Error> where T : Decodable {
        let path = responsePathForRequest?(request)

        let data = try? Data(contentsOf: URL(fileURLWithPath: path ?? ""), options: [])

        return Just(data ?? Data())
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
