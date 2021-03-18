//
//  HistoryDetailVM.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation
import Combine

class HistoryDetailVM {
  
  // MARK: - Properties
  var activity: Activity

  let tableViewCells = [
    HistoryDetailCell.reuseIdentifier,
    HistoryDetailCell.reuseIdentifier
  ]

  let sectionHeaderFooterViews = [
    HistoryDetailSectionHeaderView.reuseIdentifier,
    HistoryDetailSectionFooterView.reuseIdentifier
  ]

  let sectionHeaderTitle = [
    "Contact Information",
    "Call Information"
  ]

  // MARK: - Initializer
  init(activity: Activity) {
    self.activity = activity
  }

}
