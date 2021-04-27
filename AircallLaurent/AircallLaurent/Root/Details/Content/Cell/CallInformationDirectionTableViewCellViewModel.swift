//
//  CallInformationDirectionTableViewCellViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

class CallInformationDirectionTableViewCellViewModel:
  GenericTableViewCellViewModelProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private let call: CallModel

  /****************** GenericTableViewCellViewModelProtocol ******************/

  var iconImage: UIImage?

  var actionButtonImage: UIImage?

  var primaryTitleText: String {
    return call.callType.rawValue
  }

  var primarySubtitleText: String {
    return "Subtitle"
  }

  var secondaryTitleText: String? {
    return nil
  }

  var secondarySubtitleText: String? {
    return nil
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(from call: CallModel) {
    self.call = call

    actionButtonImage = call.direction == .inbound
      ? UIImage(systemName: "phone.fill.arrow.up.right")
      : UIImage(systemName: "phone.fill.arrow.down.left")
  }
}
