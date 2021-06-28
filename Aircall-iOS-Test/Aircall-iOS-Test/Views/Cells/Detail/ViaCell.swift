//
//  ViaCell.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import UIKit

class ViaCell: UITableViewCell, ActivityConfigurableCell {

  @IBOutlet private weak var viaLabel: UILabel!

  func configure(with activity: Activity) {
    self.viaLabel.text = ["via", activity.via ?? "unknown"].joined(separator: " ")
  }
}
