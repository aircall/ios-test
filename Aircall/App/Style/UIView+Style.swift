//
//  UIView+Design.swift
//  Aircall
//
//  Created by JC on 20/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func styleBox() {
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        layer.cornerRadius = 4
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        layer.borderWidth = 1
    }
}
