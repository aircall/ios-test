//
//  URLResponse+Validate.swift
//  Aircall
//
//  Created by JC on 20/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine

extension URLResponse {
    @objc
    func validate() throws { }
}

extension HTTPURLResponse {
    @objc
    override func validate() throws {
        guard (200..<300).contains(statusCode) else {
            /// We should send a more precise error. For the test just sand a generic one
            throw URLError(.badServerResponse)
        }
    }
}

extension URLSession.DataTaskPublisher {
    func validate() -> AnyPublisher<Output, Error> {
        tryMap {
            try $0.response.validate()
            return $0
        }
            .eraseToAnyPublisher()
    }
}
