//
//  UIColor+Name.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import UIKit

extension UIColor {

  class var inboundIconColor: UIColor {
    return loadColorWith(name: "OutrageousOrange")
  }

  class var outboundIconColor: UIColor {
    return loadColorWith(name: "PersianGreen")
  }

  fileprivate class func loadColorWith( name: String) -> UIColor {
    guard let color = UIColor(named: name) else { fatalError("Couln't find \(name) color") }
    return color
  }

}
