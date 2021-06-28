//
//  PresenterExtensions.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 27/06/2021.
//

import UIKit

extension UIStoryboard {
  static let main = UIStoryboard(name: "Main", bundle: nil)
}

extension UIViewController {
  static let activitiesViewController = UIStoryboard.main.instantiateViewController(withIdentifier: "activitiesViewController")
  static let detailsViewController = UIStoryboard.main.instantiateViewController(withIdentifier: "detailsViewController")
}

