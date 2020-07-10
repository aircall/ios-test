//
//  DirectionViewComponent.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import UIKit

enum DirectionViewComponent {
    static func render(_ direction: Call.Direction, in view: UIImageView) {
        view.image = UIImage(systemName: ImageStyle.image(for: direction).rawValue)
        view.tintColor = UIColor.color(for: direction)
    }
}

extension ImageStyle {
    static func image(for direction: Call.Direction) -> ImageStyle {
        direction == .inbound ? .incomingCall : .outgoingCall
    }
}

extension UIColor {
    static func color(for direction: Call.Direction) -> UIColor {
        direction == .inbound ? .green : .red
    }
}
