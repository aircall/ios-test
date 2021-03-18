//
//  ACLStateView.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import UIKit

class ACLStateView: UIView {

  // MARK: - Properties
  private var nibName: String {
    return String(describing: type(of: self))
  }

  var didPressActionButton: (() -> Void)?

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var actionButton: UIButton!

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

  init(message: String, buttonTitle: String) {
    super.init(frame: .zero)
    loadViewFromNib()
    setupXib()

    messageLabel.text = message
    actionButton.setTitle(buttonTitle, for: .normal)
  }

  private func setupXib() {
    actionButton.addTarget(self, action: #selector(handlePressAction), for: .touchUpInside)
  }

  @objc private func handlePressAction() {
    guard let didPressAction = didPressActionButton else { return }
    didPressAction()
  }

  // MARK: - Methods
  private func loadViewFromNib() {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)

    containerView = nib.instantiate(withOwner: self, options: nil).first as? UIView
    containerView.frame = bounds
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    addSubview(containerView)
   }
}
