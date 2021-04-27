//
//  GenericTableViewCellViewModelProtocol.swift
//  AircallLaurent
//
//  Created by Laurent on 27/04/2021.
//

import UIKit

/*******************************************************************************
 * GenericTableViewCellViewModelProtocol
 *
 * A type that can populate a GenericTableViewCell
 *
 ******************************************************************************/

protocol GenericTableViewCellViewModelProtocol {
  var iconImage: UIImage? { get set }
  var primaryTitleText: String { get }
  var primarySubtitleText: String { get }
  var secondaryTitleText: String? { get }
  var secondarySubtitleText: String? { get }
  var isSecondaryTextAreaHidden: Bool { get }
  var isActionButtonHidden: Bool { get }
}


//==============================================================================
// MARK: - Default implementation
//==============================================================================

extension GenericTableViewCellViewModelProtocol {

  var isSecondaryTextAreaHidden: Bool {
    return secondaryTitleText == nil && secondarySubtitleText == nil
  }

}
