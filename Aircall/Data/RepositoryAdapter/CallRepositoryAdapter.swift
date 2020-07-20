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
    
    init(aircall: AircallRestDataSource = CacheDataSourceProxy(dataSource: AircallRestClient.default())) {
        self.aircall = aircall
    }
    
    func loadAll() -> AnyPublisher<[Call], Error> {
        aircall
            .findActivities()
            .map { $0.filter { !$0.isArchived } }
            .eraseToAnyPublisher()
    }
    
    func archive(call: Call) -> AnyPublisher<Call, Error> {
        var call = call
        call.isArchived = true

        return aircall
            .saveActivity(call: call)
            .map { call }
            .eraseToAnyPublisher()
    }
}
