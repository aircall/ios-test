//
//  ActionView.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import UIKit

/*******************************************************************************
 * ActionView
 *
 * An item used to call for an action
 *
 ******************************************************************************/

class ActionView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet var contentView: UIView!
  @IBOutlet weak private var imageView: UIImageView!
  @IBOutlet weak private var textLabel: UILabel!

  /******************** Labels ********************/

  /// Image of the view
  @IBInspectable var image: UIImage? {
    get { return imageView.image }
    set { imageView.image = newValue }
  }

  /// Tile of the view
  @IBInspectable var titleText: String? {
    get { return textLabel.text }
    set { textLabel.text = newValue }
  }

  /******************** Callbacks ********************/

  var didTap: (() -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    loadNib()
    setupView()
    setupContentView()
    setupImage()
    setupTitle()
  }

  private func setupView() {
    backgroundColor = .white
    cornerRadius = 10
    applyShadow(opacity: 0.25, radius: CGFloat(cornerRadius))
  }

  private func setupContentView() {
    contentView.backgroundColor = .clear
    add(subview: contentView, with: .edge)
  }

  private func setupImage() {
    imageView.image = nil
  }

  private func setupTitle() {
    textLabel.numberOfLines = 1
    textLabel.font = UIFont.systemFont(ofSize: 13)
  }

  //----------------------------------------------------------------------------
  // MARK: - Action
  //----------------------------------------------------------------------------

  @IBAction func tap(_ sender: Any) {
    didTap?()
  }

}
