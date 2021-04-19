//
//  CallRepositoryType.swift
//  Core
//
//  Created by Patricio Guzman on 17/04/2021.
//

import Combine

public protocol CallRepositoryType {
    func getCall(with id: String) -> AnyPublisher<Call, Error>
    func resetAll() -> AnyPublisher<(), Error>
    func archiveCall(with id: String) -> AnyPublisher<(), Error>
    func fetchAll() -> AnyPublisher<[Call], Error>
}
