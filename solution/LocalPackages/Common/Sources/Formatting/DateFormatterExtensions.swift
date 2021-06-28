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
    
    /**
     A `DateFormatter` that displays the date and time abreviated.
     - Remark: An example of formated date would be like 'June 12, 9:41'.
     */
    static var monthDayTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm"
        return formatter
    }
    
    /**
     A `DateFormatter` that displays the date abreviated.
     - Remark: An example of formated date would be like 'June 12'.
     */
    static var monthDay: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }
    
    /**
     A `DateFormatter` that displays the time.
     - Remark: An example of formated date would be like '9:41'.
     */
    static var time: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter
    }
}
