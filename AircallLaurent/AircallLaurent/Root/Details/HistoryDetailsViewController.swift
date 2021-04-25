//
//  HistoryDetailsViewController.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.
//

import UIKit

class HistoryDetailsViewController: UIViewController {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet weak private var InformationContainerView: UIView!
  @IBOutlet weak private var ActionContainerView: UIView!

  /******************** ViewModel ********************/

  private let viewModel: HistoryDetailsViewModel

  /******************** ViewControllers ********************/

  private lazy var actionViewController: HistoryDetailsActionViewController = {
    return HistoryDetailsActionViewController(nibName: nil, bundle: nil)
  }()

  //----------------------------------------------------------------------------
  // MARK: - Lifecycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  // Deactivate all the init except the `init(with:)` and avoid to add a
  // dependancy injection library.

  @available(*, unavailable)
  convenience init() {
    fatalError("init() has not been implemented.")
  }

  @available(*, unavailable)
  override init(nibName nibNameOrNil: String?,
                bundle nibBundleOrNil: Bundle?) {
    fatalError("init(nibNameOrNil:nibBundleOrNil:) has not been implemented.")
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  init(with viewModel: HistoryDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  private func setup() {
    setupView()
    setupDetailsActionView()
  }

  private func setupView() {

  }

  private func setupDetailsActionView() {
    actionViewController.shouldAddNote = { [weak self] in
      self?.viewModel.addNote()
    }

    actionViewController.shouldAddTags = { [weak self] in
      self?.viewModel.tag()
    }

    actionViewController.shouldAssign = { [weak self] in
      self?.viewModel.assign()
    }
  }
  
}
