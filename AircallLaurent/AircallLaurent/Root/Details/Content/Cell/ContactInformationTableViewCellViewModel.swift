//
//  ContactInformationTableViewCellViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

final class ContactInformationTableViewCellViewModel:
  GenericTableViewCellViewModelProtocol
{

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private let call: CallModel

  /****************** GenericTableViewCellViewModelProtocol ******************/

  var iconImage: UIImage?

  var actionButtonImage: UIImage?

  var primaryTitleText: String {
    return call.sender
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

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(from call: CallModel) {
    self.call = call
    iconImage = UIImage(systemName: "info.circle")
  }

}
