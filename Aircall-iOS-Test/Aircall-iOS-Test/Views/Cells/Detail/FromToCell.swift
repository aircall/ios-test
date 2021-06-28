//
//  FromToCell.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import UIKit

class FromToCell: UITableViewCell, ActivityConfigurableCell {

  @IBOutlet private weak var toLabel: UILabel!
  @IBOutlet private weak var fromLabel: UILabel!

  func configure(with activity: Activity) {
    self.toLabel.text = activity.to ?? "Unknown"
    self.fromLabel.text = [activity.direction.prefix, activity.from ?? "Unknown"].joined(separator: " ")
  }
}
