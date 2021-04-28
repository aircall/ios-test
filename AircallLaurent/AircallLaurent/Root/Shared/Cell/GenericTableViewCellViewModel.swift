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

  let call: CallModel

  var iconImage: UIImage?

  private let date: Date?

  var primaryTitleText: String {
    return ""
  }

  var primarySubtitleText: String {
    return ""
  }

  var secondaryTitleText: String? {
    return date?.monthDayShortFormat
  }

  var secondarySubtitleText: String? {
    return date?.timeIn24HourFormat
  }

  var isActionButtonHidden: Bool {
    return false
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(from call: CallModel) {
    self.call = call
    self.date = Date(fromISO8601: call.createdAt)

    iconImage = call.direction == .inbound
      ? UIImage(systemName: "phone.fill.arrow.up.right")
      : UIImage(systemName: "phone.fill.arrow.down.left")
  }

}
