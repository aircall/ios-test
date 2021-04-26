//
//  uiviewcontroller+Container.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.
//

import UIKit

extension UIViewController {

  func add(asChildViewController viewController: UIViewController,
           on view: UIView) {
    // Add Child View Controller
    addChild(viewController)

    // Add Child View as Subview
    view.add(subview: viewController.view, with: .edge)

    // Notify Child View Controller
    viewController.didMove(toParent: self)
  }

  func remove(asChildViewController viewController: UIViewController) {
    // Notify Child View Controller
    viewController.willMove(toParent: self)

    // Remove Child View From Superview
    viewController.view.removeFromSuperview()

    // Notify Child View Controller
    viewController.removeFromParent()
  }

}
