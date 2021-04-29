//
//  GenericTableViewCell.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import UIKit

class GenericTableViewCell: UITableViewCell, Reusable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Colors ********************/

  private let primaryColor: UIColor = .black
  private let secondaryColor: UIColor = .lightGray

  /******************** Attributes ********************/

  var textTitleAttributes: [NSAttributedString.Key: Any] {
    return [
      .foregroundColor: primaryColor,
      .backgroundColor: UIColor.clear,
      .font: UIFont.boldSystemFont(ofSize: 17)
    ]
  }

  var textSubtitleAttributes: [NSAttributedString.Key: Any] {
    return [
      .foregroundColor: secondaryColor,
      .backgroundColor: UIColor.clear,
      .font: UIFont.boldSystemFont(ofSize: 15)
    ]
  }

  var detailTextTitleAttributes: [NSAttributedString.Key: Any] {
    return [
      .foregroundColor: secondaryColor,
      .backgroundColor: UIColor.clear,
      .font: UIFont.systemFont(ofSize: 13)
    ]
  }

  var detailTextSubtitleAttributes: [NSAttributedString.Key: Any] {
    return [
      .foregroundColor: secondaryColor,
      .backgroundColor: UIColor.clear,
      .font: UIFont.systemFont(ofSize: 13)
    ]
  }

  /******************** Callbacks ********************/

  var didTapAction: (() -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Lifecycle
  //----------------------------------------------------------------------------

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    didTapAction = nil
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private func setup() {
    setupView()
    setupTextLabel()
    setupDetailTextLabel()
  }

  private func setupView() {
    backgroundColor = .clear
  }

  private func setupIconImageView() {

  }

  private func setupTextLabel() {
    textLabel?.numberOfLines = 0
    textLabel?.lineBreakMode = .byTruncatingTail
  }

  private func setupDetailTextLabel() {
    detailTextLabel?.numberOfLines = 0
    detailTextLabel?.lineBreakMode = .byTruncatingTail
  }

}

//==============================================================================
// MARK: - Configurable
//==============================================================================

extension GenericTableViewCell: Configurable {

  func configure(with data: GenericTableViewCellViewModelProtocol) {
    imageView?.image = data.iconImage

    textLabel?.attributedText = generateTextLabelAttributedString(from: data)

    if let detailTextAttributedString =
        generateDetailTextLabelAttributedString(from: data) {
      detailTextLabel?.attributedText = detailTextAttributedString
    } else {
      detailTextLabel?.isHidden = true
    }

    accessoryType = data.isActionButtonHidden ? .none : .detailButton
  }

  private func generateTextLabelAttributedString(
    from data: GenericTableViewCellViewModelProtocol
  ) -> NSMutableAttributedString {
    let attributedText = NSMutableAttributedString()
    let titleAttributedString = NSAttributedString(
      string: data.primaryTitleText,
      attributes: textTitleAttributes
    )
    let subtitleAttributedString = NSAttributedString(
      string: "\n\(data.primarySubtitleText)",
      attributes: textSubtitleAttributes
    )
    attributedText.append(titleAttributedString)
    attributedText.append(subtitleAttributedString)
    return attributedText
  }

  private func generateDetailTextLabelAttributedString(
    from data: GenericTableViewCellViewModelProtocol
  ) -> NSMutableAttributedString? {
    guard let secondaryTitleText = data.secondaryTitleText,
          let secondarySubtitleText = data.secondarySubtitleText else {
      return nil
    }
    let attributedText = NSMutableAttributedString()
    let titleAttributedString = NSAttributedString(
      string: secondaryTitleText,
      attributes: detailTextTitleAttributes
    )
    let subtitleAttributedString = NSAttributedString(
      string: "\n\(secondarySubtitleText)",
      attributes: detailTextSubtitleAttributes
    )
    attributedText.append(titleAttributedString)
    attributedText.append(subtitleAttributedString)
    return attributedText
  }
  
}
