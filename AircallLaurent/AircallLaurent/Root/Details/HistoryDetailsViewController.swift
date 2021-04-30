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

  @IBOutlet weak private var informationContainerView: UIView!
  @IBOutlet weak private var actionContainerView: UIView!
  @IBOutlet weak private var placeHolderView: UIView!
  @IBOutlet weak private var placeHolderLabel: UILabel!

  /******************** ViewModels ********************/

  private let viewModel: HistoryDetailsViewModel

  var call: CallModel? {
    didSet {
      if let call = call {
        update(with: call)
        placeHolderView.isHidden = true
      } else {
        placeHolderView.isHidden = false
        navigationItem.title = ""
      }
    }
  }

  /******************** ViewControllers ********************/

  private let informationViewController =
    HistoryDetailsInformationViewController()

  private let actionViewController =
    HistoryDetailsActionViewController(nibName: nil, bundle: nil)

  /******************** Callbacks ********************/

  var shouldArchive: ((CallModel) -> Void)?

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
    setupPlaceHolder()
    setupNavigationBar()
    setupDetailsContentView()
    setupDetailsActionView()
    setupViewModel()
  }

  private func setupView() {
    view.backgroundColor = .white
  }

  private func setupPlaceHolder() {
    placeHolderView.backgroundColor = .white
    placeHolderLabel.font = UIFont.systemFont(ofSize: 24)
    placeHolderLabel.text = viewModel.placeholderText
  }

  private func setupNavigationBar() {
    setupNavigationBarTitle()
    setupNavigationBarAction()
  }

  private func setupNavigationBarTitle() {
    navigationController?.navigationBar.prefersLargeTitles = false
  }

  private func setupNavigationBarAction() {
    let actionButton = UIBarButtonItem(barButtonSystemItem: .action,
                                       target: self,
                                       action: #selector(doAction))
    navigationItem.rightBarButtonItem = actionButton
  }

  private func setupDetailsContentView() {
    informationViewController.didFail = { error in
      print(error)
    }

    add(asChildViewController: informationViewController,
        on: informationContainerView)
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

    add(asChildViewController: actionViewController, on: actionContainerView)
  }

  private func setupViewModel() {
    viewModel.shouldUpdateTitle = { [weak self] title in
      self?.navigationItem.title = title
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  private func update(with call: CallModel) {
    viewModel.call = call
    informationViewController.update(with: call)
  }

  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

  @objc private func doAction() {
    guard let call = call else { return }
    shouldArchive?(call)
  }
  
}
