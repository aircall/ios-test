//
//  CallInformationPhoneOperatorTableViewCellViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

final class CallInformationPhoneOperatorTableViewCellViewModel:
  GenericTableViewCellViewModelProtocol
{

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let call: CallModel

  var iconImage: UIImage?

  var primaryTitleText: String {
    return call.phoneOperator.isEmpty
      ? "Phone operator not found" : call.phoneOperator
  }

  var primarySubtitleText: String {
    return call.sender
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
    iconImage = UIImage(systemName: "flag")
  }

}

