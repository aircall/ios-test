//
//  HistoryDetailSectionHeaderView.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

/// HistoryDetail section header view
/// Custom header view on grouped tableView
class HistoryDetailSectionHeaderView: UITableViewHeaderFooterView {

  // MARK: - Properties
  static let reuseIdentifier = "HistoryDetailSectionHeaderView"

  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }

  // MARK: - IBOutlet
  @IBOutlet weak var sectionLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!

  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    sectionLabel.text = ""
  }

  // MARK: - Methods

  /// Update ui cell with activity payload
  func setupSectionHeader(at section: HeaderSectionType, title: String, _ activity: Activity) {
    sectionLabel.text = title
    durationLabel.text = activity.duration.getDuration()

    switch section {
    case .contact:
      durationLabel.isHidden = true
    default:
      durationLabel.isHidden = false
    }
  }
  
}
