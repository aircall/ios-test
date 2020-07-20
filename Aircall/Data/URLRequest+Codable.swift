//
//  URLRequest+Codable.swift
//  Aircall
//
//  Created by JC on 20/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine

extension URLRequest {
    func body<Item: Encodable>(_ item: Item, encoder: JSONEncoder) throws -> Self {
        try body(item, encoder: encoder, contentType: "application/json")
    }
    
    func body<Item: Encodable, Encoder: TopLevelEncoder>(_ body: Item, encoder: Encoder, contentType: String) throws -> Self
        where Encoder.Output == Data {
            var request = self
            
            request.httpMethod = "POST"
            request.httpBody = try encoder.encode(body)
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
            
            return request
    }
}
