//
//  CallRepositoryMock.swift
//  CoreTests
//
//  Created by Patricio Guzman on 17/04/2021.
//

import Core
import Combine
import NetworkingMocks

class CallRepositoryMock: CallRepositoryType {

    var calls: [Call] = []
    var persistedCalls: [Call] = []

    func getCall(with id: String) -> AnyPublisher<Call, Error> {
        Just(calls[0]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func resetAll() -> AnyPublisher<(), Error> {
        calls = persistedCalls
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func archiveCall(with id: String) -> AnyPublisher<(), Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func fetchAll() -> AnyPublisher<[Call], Error> {
        Just(calls).setFailureType(to: Error.self).eraseToAnyPublisher()
    }


}
