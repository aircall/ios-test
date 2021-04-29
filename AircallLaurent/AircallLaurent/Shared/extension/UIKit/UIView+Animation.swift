//
//  UIView+Animation.swift
//  AircallLaurent
//
//  Created by Laurent on 29/04/2021.
//

import UIKit

extension UIView {

  func showAnimation(duration: TimeInterval = 0.1,
                     completion: @escaping () -> Void) {
    isUserInteractionEnabled = false

    let delay: TimeInterval = 0

    let animationOption: UIView.AnimationOptions = .curveLinear

    let shrinkAnimation: () -> Void = { [weak self] in
      self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
     }

    let growAnimation: () -> Void = { [weak self] in
      self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
     }

    let shrinkCompletion: ((Bool) -> Void)? = { [weak self] isDone in
      UIView.animate(withDuration: duration,
                     delay: delay,
                     options: animationOption,
                     animations: growAnimation) { [weak self] _ in
        self?.isUserInteractionEnabled = true
        completion()
      }
    }

    UIView.animate(withDuration: duration,
                   delay: delay,
                   options: .curveLinear,
                   animations: shrinkAnimation,
                   completion: shrinkCompletion)
  }

}
