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

  var didPressCopy: (() -> Void)?

  // MARK: - IBOutlet
  @IBOutlet weak var containerView: UIView!
  
  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - Actions
  @IBAction func copyCallAction(_ sender: Any) {
    guard  let didPressCopy = didPressCopy else { return }
    didPressCopy()
  }
}
