//
//  CallRepositoryAdapter.swift
//  Aircall
//
//  Created by JC on 19/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine

final class CallRepositoryAdapter: CallRepository {
    private let aircall: AircallRestDataSource
    
    init(aircall: AircallRestDataSource) {
        self.aircall = aircall
    }
    
    func loadAll() -> AnyPublisher<[Call], Error> {
        aircall.findActivities()
    }
    
    func save(call: Call) -> AnyPublisher<Call, Error> {
        aircall
            .saveActivity(call: call)
            .map { call }
            .eraseToAnyPublisher()
    }
}
