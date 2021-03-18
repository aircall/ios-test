//
//  HistoryDetailSectionFooterView.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

class HistoryDetailSectionFooterView: UITableViewHeaderFooterView {

  // MARK: - Properties
  static let reuseIdentifier = "HistoryDetailSectionFooterView"

  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }

  @IBOutlet weak var containerView: UIView!
  
  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

}
