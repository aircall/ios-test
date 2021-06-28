//
//  File.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Combine
@testable import Common
@testable import Domain
import Foundation

final class MockCallsRepository: CallsRepository {

    var error: Error?

    func list(with completion: @escaping (Result<[Call], Error>) -> Void) -> Cancellable? {
        if let error = error {
            completion(.failure(error))
        } else {
            let mockCalls = MockedEntities.calls
            completion(.success(mockCalls))
        }
        return nil
    }

    func archiveCall(with callId: UInt, archive: Bool, completion: @escaping (Result<Call, Error>) -> Void) -> Cancellable? {
        if let error = error {
            completion(.failure(error))
        } else {
            guard let call = MockedEntities.calls.first(where: { $0.id == callId }) else {
                fatalError("Expected call with id \(callId) in the mocked entities")
            }
            let modifiedCall = archive ? call.archivedCopy : call.unarchivedCopy
            completion(.success(modifiedCall))
        }
        return nil
    }
}

enum MockCallsRepositoryError: Error {
    case test
}

extension Call {
    var archivedCopy: Call {
        return Call(id: id,
                    createdAt: createdAt,
                    direction: direction,
                    from: from,
                    to: to,
                    via: via,
                    duration: duration,
                    isArchived: true,
                    type: type)
    }

    var unarchivedCopy: Call {
        return Call(id: id,
                    createdAt: createdAt,
                    direction: direction,
                    from: from,
                    to: to,
                    via: via,
                    duration: duration,
                    isArchived: false,
                    type: type)
    }
}
