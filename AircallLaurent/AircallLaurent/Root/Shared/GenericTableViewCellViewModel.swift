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

  var primaryTitleText: String {
    return ""
  }

  var primarySubtitleText: String {
    return ""
  }

  var secondaryTitleText: String? {
    return ""
  }

  var secondarySubtitleText: String? {
    return ""
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
  }

}
