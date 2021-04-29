//
//  HistoryDetailsActionViewController.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import UIKit

class HistoryDetailsActionViewController: UIViewController, Themeable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet weak private var copyButton: UIButton!

  @IBOutlet weak private var noteActionView: ActionView!
  @IBOutlet weak private var tagsActionView: ActionView!
  @IBOutlet weak private var assignActionView: ActionView!

  /******************** Themeable ********************/

  var themeColor: UIColor = .green

  /******************** Callbacks ********************/

  var shouldAddNote: (() -> Void)?

  var shouldAddTags: (() -> Void)?

  var shouldAssign: (() -> Void)?

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

  private func setup() {
    setupView()
    setupActionViews()
    setupCopyButton()
  }

  private func setupView() {
    view.backgroundColor = .clear
  }

  private func setupActionViews() {
    setupNoteActionView()
    setupTagsActionView()
    setupAssignActionView()
  }

  private func setupNoteActionView() {
    noteActionView.titleText = "Notes"

    let image = UIImage(systemName: "note")
    assert(image != nil, "Image not found") // Not handling error for this test

    noteActionView.image = image

    noteActionView.didTap = { [weak self] in
      self?.noteActionView.showAnimation {
        self?.shouldAddNote?()
      }
    }
  }

  private func setupTagsActionView() {
    tagsActionView.titleText = "Tags"

    let image = UIImage(systemName: "tag")
    assert(image != nil, "Image not found") // Not handling error for this test

    tagsActionView.image = image

    tagsActionView.didTap = { [weak self] in
      self?.tagsActionView.showAnimation {
        self?.shouldAddTags?()
      }
    }
  }

  private func setupAssignActionView() {
    assignActionView.titleText = "Assign"

    let image = UIImage(systemName: "person.badge.plus")
    assert(image != nil, "Image not found") // Not handling error for this test
    assignActionView.image = image


    assignActionView.didTap = { [weak self] in
      self?.assignActionView.showAnimation {
        self?.shouldAssign?()
      }
    }
  }

  private func setupCopyButton() {
    let copyButtonTitle = "Copy call ID"
    copyButton.setTitle(copyButtonTitle, for: .normal)
    copyButton.setTitleColor(themeColor, for: .normal)
  }

}
