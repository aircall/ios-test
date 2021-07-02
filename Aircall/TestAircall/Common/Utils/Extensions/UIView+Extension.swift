//
//  UIView+Extensions.swift
//  TestAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import Foundation
import UIKit

extension UIView: ReusableView {}

// MARK: - Shimmering

extension UIView {
    
    func startShimmering() {
        layoutIfNeeded()
        let lightColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: 0, width: 3 * bounds.size.width, height: 3 * bounds.size.height)

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        gradientLayer.locations =  [0.35, 0.50, 0.65]
        layer.mask = gradientLayer
        
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(1.5)
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }

    func stopShimmering() {
        layer.mask = nil
    }
}
