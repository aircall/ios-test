//
//  HistoryDefaultCell.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

/// Default cell implementation
/// Cell to keep it simple and avoid to repeat icon logic to other cell
class HistoryDefaultCell: UITableViewCell {

  // MARK: - IBOutlet
  @IBOutlet weak var iconInAndOutbound: UIImageView!

  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - Methods

  // Set tint color in terms of call direction: inbound or outbound
  func setupIcon(activity: Activity) {
    iconInAndOutbound.image = UIImage(named: activity.direction == .inbound ? "icon_inbound" : "icon_outbound")
    iconInAndOutbound.setImageColor(color: activity.direction == .inbound ? UIColor.inboundIconColor : UIColor.outboundIconColor)
  }
}
