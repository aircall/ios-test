//
//  ActivityUI.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import UIKit

public struct ActivityUI {
    let call: String
    let date: String
    let picto: UIImage?
    let color: UIColor
    let legend: String
}

extension ActivityUI {
    
    /// Build UI object from business object
    init(_ activity: Activity) {
        self.date = activity.creationDate.toString(format: .activity)
        switch activity.direction {
        case .inbound:
            self.call = activity.from
            self.legend = "Activities_inbound_via".localized([activity.via])
        case .outbound:
            self.call = activity.to ?? ""
            self.legend = "Activities_outbound_via".localized([activity.via])
        default:
            self.call = ""
            self.legend = ""
            break
        }
        self.picto = activity.direction.picto
        self.color = activity.type.color
    }
}
