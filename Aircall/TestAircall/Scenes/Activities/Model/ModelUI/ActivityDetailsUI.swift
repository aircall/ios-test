//
//  ActivityDetailsUI.swift
//  TestAircall
//
//  Created by Delphine Garcia on 30/06/2021.
//

import UIKit

public struct ActivityDetailsUI {
    let call: String
    let date: String
    let picto: UIImage?
    let color: UIColor
    let legend: String
    let duration: String
}

extension ActivityDetailsUI {
    
    /// Build UI object from business object
    init(_ activity: Activity) {
        self.date = activity.creationDate.toString(format: .activityDetails)
        var legend = ""
        switch activity.direction {
        case .inbound:
            self.call = activity.from
            legend = "Activity_details_incoming".localized.capitalized + " " + activity.type.label
        case .outbound:
            self.call = activity.to ?? ""
            legend = "Activity_details_outcoming".localized.capitalized + " " + activity.type.label
        default:
            self.call = ""
            break
        }
        self.legend = legend
        self.picto = activity.direction.picto
        self.color = activity.type.color
        self.duration = activity.duration
    }
}
