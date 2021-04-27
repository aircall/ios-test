//
//  GenericTableViewCellViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import UIKit

final class GenericTableViewCellViewModel: GenericTableViewCellViewModelProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private let call: CallModel

  var iconImage: UIImage?

  var actionButtonImage: UIImage?

  let date: Date

  var primaryTitleText: String {
    return ""
  }

  var primarySubtitleText: String {
    return ""
  }

  var secondaryTitleText: String? {
    return date.monthDayShortFormat
  }

  var secondarySubtitleText: String? {
    return date.timeIn24HourFormat
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(from call: CallModel) {
    self.call = call
    self.iconImage = nil
    self.actionButtonImage = nil
    self.date = Date()
  }

}
