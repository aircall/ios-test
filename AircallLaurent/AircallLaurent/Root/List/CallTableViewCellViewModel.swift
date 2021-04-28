//
//  CallTableViewCellViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import UIKit

final class CallTableViewCellViewModel: GenericTableViewCellViewModelProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let call: CallModel

  var iconImage: UIImage?

  private let date: Date?

  var primaryTitleText: String {
    return call.receiver ?? ""
  }

  var primarySubtitleText: String {
    return call.sender
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

  init(with call: CallModel) {
    self.call = call

    self.date = Date(fromISO8601: call.createdAt)

    iconImage = call.direction == .inbound
      ? UIImage(systemName: "phone.fill.arrow.up.right")
      : UIImage(systemName: "phone.fill.arrow.down.left")
  }

}
