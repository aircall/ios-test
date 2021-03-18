//
//  UIImage+Color.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import UIKit

extension UIImageView {

  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)

    self.image = templateImage
    self.tintColor = color
  }

}
