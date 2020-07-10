//
//  DateConverter.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation

enum DateConverter {
    enum Format: String {
        case hour = "HH:mm"
    }
    
    static func string(_ date: Date, to format: Format, locale: Locale = .current) -> String {
        // we could optimize and cache dateformatter
        let formatter = DateFormatter()
        
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate(format.rawValue)
        
        return formatter.string(from: date)
    }
}
