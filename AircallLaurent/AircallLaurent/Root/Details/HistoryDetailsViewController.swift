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

  /******************** ViewModels ********************/

  private let viewModel: HistoryDetailsViewModel

  var call: CallModel? {
    didSet {
      update(with: call)
    }
  }

  /******************** ViewControllers ********************/

  private let informationViewController =
    HistoryDetailsInformationViewController()

  private let actionViewController =
    HistoryDetailsActionViewController(nibName: nil, bundle: nil)

  //----------------------------------------------------------------------------
  // MARK: - Lifecycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    update(with: nil)
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
    setupNavigationBar()
    setupDetailsContentView()
    setupDetailsActionView()
    setupViewModel()
  }

  private func setupView() {
    view.backgroundColor = .white
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
    informationViewController.didFail = { [weak self] error in
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

  private func update(with call: CallModel?) {
//    let call = CallModel(id: 31,
//                         createdAt: "2018-04-19T09:38:41.000Z",
//                         direction: .outbound,
//                         sender: "Pierre-Baptiste Béchu",
//                         receiver: "06 46 62 12 33",
//                         phoneOperator: "NYC Office",
//                         duration: "120",
//                         isArchived: false,
//                         callType: .missed)
    guard let call = call else { return }
    viewModel.call = call
    informationViewController.update(with: call)
  }


  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

  @objc private func doAction() {

  }
  
}
