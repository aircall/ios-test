//
//  CallViewComponent.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import UIKit

enum CallNumberViewComponent {
    /// Render called/calling person based on `call.direction`
    static func render(_ call: Call, in label: UILabel) {
        switch call.direction {
        case .inbound:
            label.text = CallerConverter.string(caller: call.from)
        case .outbound:
            label.text = call.to.map(CallerConverter.string(caller:))
            
        }
    }
}
    
enum CallInfoViewComponent {
    /// Render call info based on its direction
    static func render(_ call: Call, detailed: Bool = false, in label: UILabel) {
        switch (call.direction) {
        case .inbound:
            label.text = CallStatusConverter.string(status: call.callType)
        case .outbound where detailed:
            label.text = "by " + CallerConverter.string(caller: call.from) + " via \(call.via)"
        case .outbound:
            label.text = "by " + CallerConverter.string(caller: call.from)
        }
    }
}

enum CallDurationViewComponent {
    static func render(_ duration: Duration, status: Call.Status, in label: UILabel) {
        label.isHidden = status != .answered
        label.text = DurationConverter.string(duration: duration)
    }
}
