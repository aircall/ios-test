//
//  UIView+AutoLayout.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.
//

import UIKit

extension UIView {

  /// Add a view with given contraint type that will be activated.
  ///
  /// - Parameters:
  ///   - subview: The view to be added.
  ///   - superview: The view that will contain the view.
  ///   - constraintType: The constraint type to apply to the the subview.
  func add(subview: UIView,
           with constraintType: ConstraintType) {
    addSubview(subview)

    let constraints = constraintType.constraints(subview: subview,
                                                 superview: self)

    NSLayoutConstraint.useAndActivateConstraints(constraints: constraints)
  }

  /// Add a view with given constraints that will be activated.
  ///
  /// - Parameters:
  ///   - subview: The view to be added.
  ///   - constraints: The constraints to apply to the the subview.
  func add(subview: UIView,
           with constraints: [NSLayoutConstraint]) {
    addSubview(subview)
    NSLayoutConstraint.useAndActivateConstraints(constraints: constraints)
  }

}

// Should move in NSLayoutConstraint+extension. Here before validation.
extension NSLayoutConstraint {

  /// Active the given constraints and set the related view autoresizing mask to
  /// false.
  ///
  /// - Parameter constraints: The constraints to activate.
  class func useAndActivateConstraints(constraints: [NSLayoutConstraint]) {
    for constraint in constraints {
      if let view = constraint.firstItem as? UIView {
        view.translatesAutoresizingMaskIntoConstraints = false
      }
    }
    activate(constraints)
  }

}
