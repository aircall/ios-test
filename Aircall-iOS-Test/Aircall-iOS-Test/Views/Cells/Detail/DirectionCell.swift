//
//  DirectionCell.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import UIKit

class DirectionCell: UITableViewCell, ActivityConfigurableCell {

  @IBOutlet private weak var directionImageView: UIImageView!
  @IBOutlet private weak var directionLabel: UILabel!

  override func prepareForReuse() {
    super.prepareForReuse()

    self.directionImageView.image = nil
    self.directionImageView.tintColor = .label
  }

  func configure(with activity: Activity) {
    self.directionImageView.image = activity.direction.image
    self.directionImageView.tintColor = activity.callType.color
    self.directionLabel.text = [activity.direction.rawValue, "call", activity.callType.rawValue].joined(separator: " ")
  }
}
