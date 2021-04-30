//
//  CallInformationDirectionTableViewCellViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

final class CallInformationDirectionTableViewCellViewModel:
  GenericTableViewCellViewModelProtocol
{

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let call: CallModel

  var iconImage: UIImage?

  var primaryTitleText: String {
    return call.callType.rawValue
  }

  var primarySubtitleText: String {
    return ""
  }

  var secondaryTitleText: String? {
    return nil
  }

  var secondarySubtitleText: String? {
    return nil
  }

  var isActionButtonHidden: Bool {
    return true
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with call: CallModel) {
    self.call = call

    iconImage = call.direction == .inbound
      ? UIImage(systemName: "phone.fill.arrow.up.right")
      : UIImage(systemName: "phone.fill.arrow.down.left")
  }

}
