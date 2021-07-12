//
//  String.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation

extension String {
    func iso8601Date() -> Date? {
        return DateFormatter.iso8601.date(from: self)
    }
}
    
