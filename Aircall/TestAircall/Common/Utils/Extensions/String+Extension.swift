//
//  String+Extension.swift
//  TestAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import Foundation

// MARK: - Localized
extension String {

    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localized(_ params: [CVarArg]) -> String {
        String(format: localized, arguments: params)
    }
}

// MARK: - Date
extension String {

    func toDate(format: CustomDateFormat) -> Date? {
        let dateFormatter = Date.dateFormatter
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        dateFormatter.dateFormat = format.rawValue
        return Date.dateFormatter.date(from: self)
    }
}
