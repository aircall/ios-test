//
//  HistoryItemCell.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

/// Cell for history viewcontroller
class HistoryItemCell: HistoryDefaultCell {

  // MARK: - Properties
  static let identifier = "HistoryItemCell"

  // MARK: - IBOutlet
  @IBOutlet weak var fromLabel: UILabel!
  @IBOutlet weak var toLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!

  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCellUI()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    iconInAndOutbound.image = nil
    fromLabel.text = ""
    toLabel.text = ""
    dateLabel.text = ""
    timeLabel.text = ""
  }

  // MARK: - Setup UI
  private func setupCellUI() {
    layoutMargins = .zero
  }

  // MARK: - Methods

  /// Update cell ui with activity payload
  func setupCellWith(_ activity: Activity) {
    setupIcon(activity: activity)

    fromLabel.text = activity.from
    toLabel.text = activity.to ?? "Unknown"
    dateLabel.text = activity.created.getFormattedDate(format: "MMM d")
    timeLabel.text = activity.created.getFormattedDate(format: "HH:mm")
  }

}
