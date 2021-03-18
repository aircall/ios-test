//
//  HistoryDefaultCell.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

class HistoryDefaultCell: UITableViewCell {

  // MARK: - IBOutlet
  @IBOutlet weak var iconInAndOutbound: UIImageView!

  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - Methods
  func setupIcon(activity: Activity) {
    iconInAndOutbound.image = UIImage(named: activity.direction == .inbound ? "icon_inbound" : "icon_outbound")
    iconInAndOutbound.setImageColor(color: activity.direction == .inbound ? UIColor.inboundIconColor : UIColor.outboundIconColor)
  }
}
