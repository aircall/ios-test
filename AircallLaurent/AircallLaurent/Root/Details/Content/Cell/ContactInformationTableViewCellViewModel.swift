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

  init(with call: CallModel) {
    self.call = call
    actionButtonImage = UIImage(systemName: "info.circle")
  }

}
