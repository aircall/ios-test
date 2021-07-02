//
//  Activity.swift
//  TestAircall
//
//  Created by Delphine Garcia on 27/06/2021.
//

import Foundation
import UIKit
import NetworkingAircall

public enum ActivityDirection: String, CaseIterable {
    case inbound
    case outbound
    case unknown
    
    var picto: UIImage? {
        switch self {
        case .inbound:
            return UIImage.arrowDownLeft
        case .outbound:
            return UIImage.arrowUpRight
        case .unknown:
            return nil
        }
    }
}

public enum CallType: String, CaseIterable  {
    case answered
    case missed
    case voicemail
    case unknown
    
    var color: UIColor {
        switch self {
        case .answered:
            return UIColor.accent
        case .missed:
            return UIColor.red
        case .voicemail, .unknown:
            return UIColor.gray
        }
    }
    
    var label: String {
        switch self {
        case .answered:
            return "Activity_details_answered".localized
        case .missed:
            return "Activity_details_missed".localized
        case .voicemail:
            return "Activity_details_voicemail".localized
        default:
            return ""
        }
    }
}

public struct Activity {
    let id: Int
    let creationDate: Date
    let direction: ActivityDirection
    let from: String
    let to: String?
    let via: String
    let duration: String
    var isArchived: Bool
    let type: CallType
}


extension Activity {
    
    /// Build business object from network object
    init(_ activity: ActivityNWK) {
        self.id = activity.id
        self.creationDate = activity.creationDate.toDate(format: .network) ?? Date()
        self.direction = ActivityDirection(rawValue: activity.direction) ?? .unknown
        self.from = activity.from
        self.to = activity.to
        self.via = activity.via
        self.duration = activity.duration
        self.isArchived = activity.isArchived
        self.type = CallType(rawValue: activity.type) ?? .unknown
    }
}
