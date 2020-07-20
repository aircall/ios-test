//
//  CacheDataProxy.swift
//  Aircall
//
//  Created by JC on 20/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine
import Reachability
import Cache

struct CacheKey: Hashable {
    let name: String
}

extension Storage where T == Data {
    static func `default`() -> Storage<T> {
        try! Storage(diskConfig: DiskConfig(name: "test"),
                     memoryConfig: MemoryConfig(),
                     transformer: TransformerFactory.forData())
    }
}

class CacheDataSourceProxy<DataSource> {
    private let storage: Storage<Data>
    private let reachability: Reachability = try! Reachability()
    private let dataSource: DataSource
    
    init(storage: Storage<Data> = .default(), dataSource: DataSource) {
        self.storage = storage
        self.dataSource = dataSource
    }
    
    func get<T: Codable>(cache key: CacheKey, fromDataSource: (DataSource)
        -> AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        
        guard reachability.connection != .unavailable else {
            return Future { promise in
                guard let cache = self.value(for: key) as T? else {
                    promise(.failure(URLError(.notConnectedToInternet)))
                    return
                }

                promise(.success(cache))
            }
            .eraseToAnyPublisher()
        }
        
        return fromDataSource(dataSource)
            .map {
                self.store($0, for: key)
                return $0
        }
        .eraseToAnyPublisher()
    }
    
    func save<T>(inDataSource: (DataSource) -> AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        inDataSource(dataSource)
    }
    
    private func value<T: Codable>(for key: CacheKey) -> T? {
        try? storage.transformCodable(ofType: T.self)
            .object(forKey: key.name)
    }
    
    func store<T: Codable>(_ value: T, for key: CacheKey) {
        try? storage.transformCodable(ofType: T.self)
            .setObject(value, forKey: key.name)
    }
}
