//
//  Date+Extension.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import Foundation

public enum CustomDateFormat: String {
    case network = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case activity = "MMM. dd \n HH:mm"
    case activityDetails = "MMM. dd, HH:mm"
}

extension Date {
    
    static let dateFormatter: DateFormatter = {
        DateFormatter()
    }()
    
    func toString(format: CustomDateFormat) -> String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
