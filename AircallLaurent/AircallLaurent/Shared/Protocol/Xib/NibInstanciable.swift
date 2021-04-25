//
//  NibInstanciable.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.

import UIKit

/*******************************************************************************
 * NibInstanciable
 *
 * Convenient protocol to loadNib in UIView classes.
 *
 ******************************************************************************/

protocol NibInstanciable: class {
  func loadNib()
}

extension NibInstanciable where Self: UIView {

  func loadNib() {
    let bundle = Bundle(for: type(of: self))
    let nibName = String(describing: Self.self)
    bundle.loadNibNamed(nibName, owner: self, options: nil)
  }

}
