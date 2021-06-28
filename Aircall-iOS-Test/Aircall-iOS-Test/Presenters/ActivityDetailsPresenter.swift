//
//  ActivityDetailsPresenter.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 27/06/2021.
//

import Foundation
import UIKit

protocol ActivityDetailsPresenterProtocol {
  var source: UIViewController { get }

  func presentErrorPopup()
  func pop()
}

struct ActivityDetailsPresenter: ActivityDetailsPresenterProtocol {
  var source: UIViewController

  func presentErrorPopup() {
    let alert = UIAlertController(title: "Whoops", message: "The activity failed to archive. Please try again", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.source.present(alert, animated: true, completion: nil)
  }

  func pop() {
    self.source.navigationController?.popViewController(animated: true)
  }
}
