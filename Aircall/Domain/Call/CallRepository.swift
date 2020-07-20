//
//  CallRepository.swift
//  Aircall
//
//  Created by JC on 19/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine

protocol CallRepository {
    func loadAll() -> AnyPublisher<[Call], Error>
    func archive(call: Call) -> AnyPublisher<Call, Error>
}
