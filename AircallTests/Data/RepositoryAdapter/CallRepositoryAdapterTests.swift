//
//  CallRepositoryAdapterTests.swift
//  AircallTests
//
//  Created by JC on 20/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import XCTest
import Combine
import GRDBCombine
@testable import Aircall

class CallRepositoryAdapterTests: XCTestCase {
    func test__loadAll__ItRemoveArchivedCalls() throws {
        let aircallMock = AircallMock()
        let repository = CallRepositoryAdapter(aircall: aircallMock)
        // This could be moved into some test fixture generator helper
        let archivedCalls = [
            Call(id: 1,
                 createdAt: Date(),
                 direction: .inbound,
                 from: .contact("Steve"),
                 to: .contact("Antoine"),
                 via: "office",
                 duration: .seconds(0),
                 isArchived: true,
                 callType: .answered)]
        let unarchivedCalls = [
            Call(id: 2,
                 createdAt: Date(),
                 direction: .inbound,
                 from: .contact("Dave"),
                 to: .contact("Dalida"),
                 via: "tv",
                 duration: .seconds(0),
                 isArchived: false,
                 callType: .missed)
        ]
        
        aircallMock.findActivitiesMock = .success(archivedCalls + unarchivedCalls)
        
        let calls = try wait(for: repository.loadAll().record().elements, timeout: 0.5)
        
        XCTAssertEqual(calls.flatMap { $0 }, unarchivedCalls)
    }
}

extension CallRepositoryAdapterTests {
    fileprivate class AircallMock: AircallRestDataSource {
        var findActivitiesMock: Result<[Call], Error>!
        var saveActivityMock: Result<Void, Error>!
        
        func findActivities() -> AnyPublisher<[Call], Error> {
            precondition(findActivitiesMock != nil)
            return findActivitiesMock.publisher.eraseToAnyPublisher()
        }
        
        func saveActivity(call: Call) -> AnyPublisher<Void, Error> {
            precondition(saveActivityMock != nil)
            return saveActivityMock.publisher.eraseToAnyPublisher()
        }
    }
}
