//
//  HistoryDetailsActionViewController.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import UIKit

class HistoryDetailsActionViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlets ********************/

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

  }

}
