//
//  ActivityListCell.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import UIKit

class ActivityListCell: UITableViewCell, ActivityConfigurableCell {

  @IBOutlet private weak var directionImageView: UIImageView!
  @IBOutlet private weak var toLabel: UILabel!
  @IBOutlet private weak var fromLabel: UILabel!
  @IBOutlet private weak var createdAtLabel: UILabel!

  override func prepareForReuse() {
    super.prepareForReuse()

    self.directionImageView.image = nil
    self.directionImageView.tintColor = .label
    self.toLabel.textColor = .label
  }

  func configure(with activity: Activity) {
    self.directionImageView.image = activity.direction.image
    self.directionImageView.tintColor = activity.callType.color
    self.toLabel.text = activity.to ?? "Unknown"
    self.toLabel.textColor = activity.callType.color
    self.fromLabel.text = [activity.direction.prefix, activity.from ?? "Unknown"].joined(separator: " ")
    self.createdAtLabel.text = Formatters.shared.shortDateTimeFormatter.string(from: activity.createdAt)
  }

}
