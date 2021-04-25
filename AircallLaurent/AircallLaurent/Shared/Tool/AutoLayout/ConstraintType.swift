//
//  ConstraintType.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.

import UIKit

/*******************************************************************************
 * ConstraintType
 *
 * Generate common constraints.
 *
 ******************************************************************************/

enum ConstraintType {

  /// Pin a view to the edges.
  case edge

  /// Center a view and resize its width and height if one.
  case center(size: CGSize? = nil)
}

//==============================================================================
// MARK: - Contraint computing
//==============================================================================

extension ConstraintType {

  /// Compute and return the constraints of a subview related to a superview
  /// related to the given case.
  ///
  /// - Parameters:
  ///   - subview: The subview
  ///   - superview: The view
  /// - Returns: Computed constraints.
  func constraints(subview: UIView,
                   superview: UIView) -> [NSLayoutConstraint] {
    switch self {
    case .edge:
      return edgeConstraints(subview: subview, superview: superview)

    case .center(let size):
      return
        centerConstraints(subview: subview, superview: superview, size: size)
    }
  }

  /// Set the relationship between a subiew and superview constraints to pin
  /// the edges of the subview to the edges of the superview.
  ///
  /// - Parameters:
  ///   - subview: The view to add constraints.
  ///   - superview: The view that contains the subview.
  /// - Returns: The computed constraints.
  private func edgeConstraints(subview: UIView,
                               superview: UIView) -> [NSLayoutConstraint] {
    return [
      subview.topAnchor.constraint(equalTo: superview.topAnchor),
      subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
      subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
    ]
  }

  /// Set the relationship between a subiew and superview constraints to move
  /// the subview at the center of the superview while optionally setting its
  /// width and height.
  /// - Parameter subview: The view to add constraints.
  /// - Parameter superview: The view that contains the subview.
  /// - Parameter size: The constraints size of the subview. If nil, the subview
  /// size won't be changed.
  private func centerConstraints(subview: UIView,
                                 superview: UIView,
                                 size: CGSize? = nil) -> [NSLayoutConstraint] {
    var constraints = [
      subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
      subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
    ]

    if let size = size {
      let widthAnchor =
        subview.widthAnchor.constraint(equalToConstant: size.width)
      let heightAnchor =
        subview.heightAnchor.constraint(equalToConstant: size.height)
      constraints.append(contentsOf: [widthAnchor, heightAnchor])
    }

    return constraints
  }

}
