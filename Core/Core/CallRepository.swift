//
//  CallRepository.swift
//  Core
//
//  Created by Patricio Guzman on 17/04/2021.
//

import Combine
import Networking

public struct CallRepository: CallRepositoryType {

    let session: SessionType

    public init(session: SessionType) {
        self.session = session
    }

    public func getCall(with id: String) -> AnyPublisher<Call, Error> {
        session.dataTaskPublisher(for: .call(id: id))
    }

    public func resetAll() -> AnyPublisher<(), Error> {
        session.dataTaskPublisher(for: .reset)
    }

    public func archiveCall(with id: String) -> AnyPublisher<(), Error> {
        session.dataTaskPublisher(for: .updateCall(id: id))
    }

    public func fetchAll() -> AnyPublisher<[Call], Error> {
        session.dataTaskPublisher(for: .calls)
    }
}
