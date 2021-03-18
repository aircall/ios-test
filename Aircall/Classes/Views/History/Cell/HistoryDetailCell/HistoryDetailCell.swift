//
//  HistoryDetailCell.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

/// Cell for history detail viewcontroller
class HistoryDetailCell: HistoryDefaultCell {

  // MARK: - Properties
  static let reuseIdentifier = "HistoryDetailCell"

  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }

  private let MIN_LEADING_CONSTRAINT: CGFloat = 10
  private let MAX_LEADING_CONSTRAINT: CGFloat = 32

  // MARK: - IBOutlet
  @IBOutlet weak var imageContainerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var stackViewLeadingConstraint: NSLayoutConstraint!

  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCellUI()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    iconInAndOutbound.image = nil
    titleLabel.text = ""
    subtitleLabel.text = ""
  }

  // MARK: - Setup UI
  private func setupCellUI() {
    selectionStyle = .none
    imageContainerView.layer.cornerRadius = 16
  }

  // MARK: - Methods

  /// Setup cell at specific section : Contact or Call
  func setupCell(at indexPath: IndexPath, section: HeaderSectionType, with activity: Activity) {
    switch section {
    case .contact:
      setupContactCellWith(activity)
    case .call:
      setupCallCellWith(activity, at: RowType(rawValue: indexPath.row) ??  RowType.callRow)
    }
  }

  /// Setup contact information cell
  private func setupContactCellWith(_ activity: Activity) {
    accessoryType = .detailButton

    stackViewLeadingConstraint.constant = MAX_LEADING_CONSTRAINT
    imageContainerView.isHidden = false
    iconInAndOutbound.isHidden = true
    subtitleLabel.isHidden = true
    titleLabel.text = activity.from
  }

  /// Setup call information cell
  private func setupCallCellWith(_ activity: Activity, at row: RowType) {
    accessoryType = .none

    imageContainerView.isHidden = row == .callRow ? true : false
    stackViewLeadingConstraint.constant = imageContainerView.isHidden ? MIN_LEADING_CONSTRAINT : MAX_LEADING_CONSTRAINT
    iconInAndOutbound.isHidden = !imageContainerView.isHidden

    if row == .callRow {
      setupIcon(activity: activity)
      titleLabel.text = activity.direction == .inbound ? "Incoming call" : "Outgoing call"
      subtitleLabel.text = activity.callType.rawValue.capitalized
    } else {
      titleLabel.text = activity.via
      subtitleLabel.text = activity.to ?? "Unknown"
    }
  }
    
}
