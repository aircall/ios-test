//
//  File.swift
//  
//
//  Created by Jobert on 23/06/2021.
//

import Foundation

public extension DateFormatter {
    /**
     A `DateFormatter` that displays the full date and time including milliseconds.
     - Remark: An example of formated date would be like '2021-06-23 09:02:25.5234'.
     */
    static var fullDateMilliseconds: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        return formatter
    }
}
