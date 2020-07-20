//
//  CacheDataProxy.swift
//  Aircall
//
//  Created by JC on 20/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation

class CacheContainer: NSObject {
    /// the cached value
    private let value: Any
    /// date after which cached date should be considered staled
    private let validUntil: Date?
    
    init(value: Any, until: Date? = nil) {
        self.value = value
        self.validUntil = until
    }
    
    func containedValue<T>() -> T? {
        guard let value = value as? T, validUntil.map({ $0 > Date() }) ?? true else {
            return nil
        }
        
        return value
    }
}
