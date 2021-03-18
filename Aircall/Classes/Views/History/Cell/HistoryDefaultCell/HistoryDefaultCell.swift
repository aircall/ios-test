//
//  HistoryDefaultCell.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

class HistoryDefaultCell: UITableViewCell {

  @IBOutlet weak var iconInAndOutbound: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func setupIcon(activity: Activity) {
    iconInAndOutbound.image = UIImage(named: activity.direction == .inbound ? "icon_inbound" : "icon_outbound")
    iconInAndOutbound.setImageColor(color: activity.direction == .inbound ? UIColor.inboundIconColor : UIColor.outboundIconColor)
  }
}
