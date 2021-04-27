//
//  GenericTableViewCell.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import UIKit

class GenericTableViewCell: UITableViewCell, Reusable {

  //--------------------------------------------------------------------------
  // MARK: - Properties
  //--------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet weak private var iconImageView: UIImageView!
  @IBOutlet weak private var primaryTitleLabel: UILabel!
  @IBOutlet weak private var primarySubtitleLabel: UILabel!
  @IBOutlet weak private var secondaryStackView: UIStackView!
  @IBOutlet weak private var secondaryTitleLabel: UILabel!
  @IBOutlet weak private var secondarySubtitleLabel: UILabel!
  @IBOutlet weak private var actionButton: UIButton!

  /******************** Colors ********************/

  private let primaryColor: UIColor = .black
  private let secondaryColor: UIColor = .lightGray

  /******************** Callbacks ********************/

  var didTapAction: (() -> Void)?

  //--------------------------------------------------------------------------
  // MARK: - Lifecycle
  //--------------------------------------------------------------------------

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  //--------------------------------------------------------------------------
  // MARK: - Initialization
  //--------------------------------------------------------------------------

  private func setup() {
    setupView()
    setupIconImageView()
    setupLabels()
    setupActionButton()
  }

  private func setupView() {
    backgroundColor = .clear
    selectionStyle = .none
  }

  private func setupIconImageView() {

  }

  private func setupLabels() {
    setupPrimaryLabels()
    setupSecondaryLabels()
  }

  private func setupPrimaryLabels() {
    setupPrimaryTitleLabel()
    setupPrimarySubtitleLabel()
  }

  private func setupPrimaryTitleLabel() {
    primaryTitleLabel.textColor = primaryColor
    primaryTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
  }

  private func setupPrimarySubtitleLabel() {
    primarySubtitleLabel.textColor = secondaryColor
    primarySubtitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
  }

  private func setupSecondaryLabels() {
    setupSecondaryTitleLabel()
    setupSecondarySubtitleLabel()
  }

  private func setupSecondaryTitleLabel() {
    secondaryTitleLabel.textColor = secondaryColor
    secondaryTitleLabel.font = UIFont.systemFont(ofSize: 13)
  }

  private func setupSecondarySubtitleLabel() {
    secondarySubtitleLabel.textColor = secondaryColor
    secondarySubtitleLabel.font = UIFont.systemFont(ofSize: 13)
  }

  private func setupActionButton() {
    actionButton.tintColor = secondaryColor
  }

  //==============================================================================
  // MARK: - Action
  //==============================================================================

  @IBAction func tapAction(_ sender: Any) {
    didTapAction?()
  }

}

//==============================================================================
// MARK: - Configurable
//==============================================================================

extension GenericTableViewCell: Configurable {

  func configure(with data: GenericTableViewCellViewModelProtocol) {
    iconImageView.image = data.iconImage
    
    primaryTitleLabel.text = data.primaryTitleText
    primarySubtitleLabel.text = data.primarySubtitleText

    secondaryTitleLabel.text = data.secondaryTitleText
    secondarySubtitleLabel.text = data.secondarySubtitleText
    secondaryStackView.isHidden = data.isSecondaryTextAreaHidden

    actionButton.setImage(data.actionButtonImage, for: .normal)
    actionButton.isHidden = data.isActionButtonHidden
  }

}
