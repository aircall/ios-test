//
//  GenericTableViewCellViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import UIKit

final class GenericTableViewCellViewModel {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let iconImage: UIImage?

  let actionButtonImage: UIImage?

  let date: Date

  var primaryTitleText: String {
    return ""
  }

  var primarySubtitleText: String {
    return ""
  }

  var secondaryTitleText: String? {
    return date.monthDayShortFormat()
  }

  var secondarySubtitleText: String? {
    return date.timeIn24HourFormat()
  }

  var isSecondaryTextAreaHidden: Bool {
    return secondaryTitleText == nil && secondarySubtitleText == nil
  }

  var isActionButtonHidden: Bool {
    return actionButtonImage == nil
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init() {
    self.iconImage = nil
    self.actionButtonImage = nil
    self.date = Date()
  }

}
