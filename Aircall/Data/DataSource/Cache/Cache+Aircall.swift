//
//  Cache+Aircall.swift
//  Aircall
//
//  Created by JC on 20/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine

extension CacheKey {
    fileprivate static let activities = CacheKey(name: "activities")
}

extension CacheDataSourceProxy: AircallRestDataSource where DataSource: AircallRestDataSource {
    func findActivities() -> AnyPublisher<[Call], Error> {
        get(cache: .activities, fromDataSource: { $0.findActivities() })
    }
    
    func saveActivity(call: Call) -> AnyPublisher<Void, Error> {
        save(inDataSource: { $0.saveActivity(call: call) })
    }
}
