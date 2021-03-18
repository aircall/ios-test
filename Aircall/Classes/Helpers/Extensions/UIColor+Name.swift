//
//  UIColor+Name.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import UIKit

extension UIColor {

  class var tableViewBackgroundColor: UIColor {
    return loadColorWith(name: "HintOfRed")
  }

  class var fromLabelColor: UIColor {
    return loadColorWith(name: "Bunker")
  }

  class var toLabelColor: UIColor {
    return loadColorWith(name: "RollingStone")
  }

  class var dateLabelColor: UIColor {
    return loadColorWith(name: "RollingStone")
  }

  class var timeLabelColor: UIColor {
    return loadColorWith(name: "RollingStone")
  }

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
