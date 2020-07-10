//
//  CallerConverter.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation

enum CallerConverter {
    static func string(caller: Caller) -> String {
        switch caller {
        case .contact(let name):
            return name
        case .phone(let number):
            return number
        }
    }
}
