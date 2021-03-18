//
//  ACLButton.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

@IBDesignable
class ACLButton: UIButton {

  // MARK: - Properties
  private var nibName: String {
    return String(describing: type(of: self))
  }

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var buttonIcon: UIImageView!
  @IBOutlet weak var buttonLabel: UILabel!

  @IBInspectable var icon: UIImage = UIImage() {
    didSet {
      buttonIcon.image = icon
    }
  }

  @IBInspectable var iconColor: UIColor = UIColor() {
    didSet {
      buttonIcon.setImageColor(color: iconColor)
    }
  }

  @IBInspectable var title: String = "" {
    didSet {
      buttonLabel.text = title
    }
  }

  @IBInspectable var buttonBackgroundColor: UIColor? {
    didSet {
      containerView.backgroundColor = buttonBackgroundColor
    }
  }

  @IBInspectable var shadowColor: UIColor = UIColor.black.withAlphaComponent(0.2) {
    didSet {
      containerView.layer.shadowColor = shadowColor.cgColor
    }
  }

  @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
    didSet {
      containerView.layer.shadowOffset = shadowOffset
    }
  }

  @IBInspectable var shadowRadius: CGFloat = 0.0 {
    didSet {
      containerView.layer.shadowRadius = shadowRadius
    }
  }

  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      containerView.layer.cornerRadius = cornerRadius
    }
  }

  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      containerView.layer.borderWidth = borderWidth
    }
  }

  @IBInspectable var borderColor: UIColor = UIColor.black {
    didSet {
      containerView.layer.borderColor = borderColor.withAlphaComponent(0.35).cgColor
    }
  }

  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    loadViewFromNib()
    setupXib()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    loadViewFromNib()
    setupXib()
  }

  // MARK: - Setup UI
  private func setupXib() {
    containerView.backgroundColor = buttonBackgroundColor

    // Border with color
    containerView.layer.borderWidth = borderWidth
    containerView.layer.borderColor = borderColor.cgColor
    containerView.layer.cornerRadius = cornerRadius

    // Shadow
    containerView.layer.shadowColor = shadowColor.cgColor
    containerView.layer.shadowOffset = shadowOffset
    containerView.layer.shadowOpacity = 0.7
    containerView.layer.shadowRadius = shadowRadius
    containerView.layer.masksToBounds = false
  }

  // MARK: - Methods
  override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    if let _ = super.hitTest(point, with: event) {
        return self
    }

    return nil
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)

    // Scale down animation on touch In
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0,
      options: .beginFromCurrentState,
      animations: {
        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
      })
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)

    // Scale up animation on touch up
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0,
      options: .beginFromCurrentState,
      animations: {
        self.transform = CGAffineTransform.identity
      })
   }

  private func loadViewFromNib() {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)

    containerView = nib.instantiate(withOwner: self, options: nil).first as? UIView
    addSubview(containerView)
    containerView.frame = bounds
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
   }

}
