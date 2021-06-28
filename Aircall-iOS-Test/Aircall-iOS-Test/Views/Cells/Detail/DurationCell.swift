//
//  DurationCell.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import UIKit

class DurationCell: UITableViewCell, ActivityConfigurableCell {

  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var durationLabel: UILabel!

  func configure(with activity: Activity) {
    self.dateLabel.text = Formatters.shared.longDateTimeFormatter.string(from: activity.createdAt)
    if let duration = TimeInterval(activity.duration) {
      self.durationLabel.text = Formatters.shared.dateComponentsFormatter.string(from: duration)
    } else {
      self.durationLabel.text = "N/A"
    }
  }
}
