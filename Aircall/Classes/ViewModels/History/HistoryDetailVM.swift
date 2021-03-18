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

  /// Array to determine how many section should be displayed
  let tableViewCells = [
    HistoryDetailCell.reuseIdentifier,
    HistoryDetailCell.reuseIdentifier
  ]

  /// Array for register custom header & footer view
  let sectionHeaderFooterViews = [
    HistoryDetailSectionHeaderView.reuseIdentifier,
    HistoryDetailSectionFooterView.reuseIdentifier
  ]

  /// Array of section title to display
  let sectionHeaderTitle = [
    "Contact Information",
    "Call Information"
  ]

  // MARK: - Initializer
  init(activity: Activity) {
    self.activity = activity
  }

}
