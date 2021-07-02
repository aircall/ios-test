//
//  Charter.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import Foundation
import UIKit

enum Charter {

    enum Margin {
        case small
        case regular
        case large
        
        var size: CGFloat {
            switch self {
            case .small:
                return 8
            case .regular:
                return 16
            case .large:
                return 32
            }
        }
    }
    
    enum Element {
        case separator
        
        var height: CGFloat {
            switch self {
            case .separator:
                return 1
            }
        }
    }
}
