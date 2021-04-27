//
//  UIView+Layer.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit


//==============================================================================
// MARK: - Shadow
//==============================================================================

extension UIView {

  /// Apply a shadow all around the view.
  ///
  /// - Parameters:
  ///   - color: The color of the shadow. Black by default.
  ///   - opacity: The opacity of the shadow in the range 0.0 (transparent)
  ///               to 1.0 (opaque). 1 by default.
  ///   - offset: The offset (in point) of the shadow layer. No offset by
  ///               default.
  ///   - radius: The blur radius (in points) used to render the shadow. 10 by
  ///               default.
  func applyShadow(color: CGColor? = UIColor.black.cgColor,
                   opacity: Float = 1,
                   offset: CGSize = .zero,
                   radius: CGFloat = 10) {
    layer.shadowColor = color
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
    layer.shadowRadius = radius
  }

}

//==============================================================================
// MARK: - Corner
//==============================================================================

extension UIView {

  /******************** Border ********************/

  var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
    set { layer.borderColor = newValue?.cgColor }
  }

  var borderWidth: CGFloat {
    get { return layer.borderWidth }
    set { layer.borderWidth = newValue }
  }

  /******************** Corner ********************/

  var cornerRadius: Double {
    get { return Double(layer.cornerRadius) }
    set { layer.cornerRadius = CGFloat(newValue) }
  }


  //----------------------------------------------------------------------------
  // MARK: - Circle
  //----------------------------------------------------------------------------

  func setAsCircle() {
    setAsCircle(withBounds: min(bounds.width, bounds.height))
  }

  func setAsCircle(withBounds bounds: CGFloat) {
    layer.cornerRadius = bounds / 2
    clipsToBounds = true
  }

}
