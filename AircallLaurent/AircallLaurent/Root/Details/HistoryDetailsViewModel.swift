//
//  HistoryDetailsViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import Foundation

/*******************************************************************************
 * HistoryDetailsViewModelProtocol
 *
 * A type that can be used as viewModel of `HistoryDetailsViewController`
 * Place here for conveniency and help me to demonstrate how to test with
 * protocols
 *
 ******************************************************************************/

protocol HistoryDetailsViewModelProtocol {
  var call: CallModel? { get set }
  var placeholderText: String { get }
  var shouldUpdateTitle: ((String) -> Void)? { get set }

  func addNote()
  func tag()
  func assign()
}

/*******************************************************************************
 * HistoryDetailsViewModel
 *
 * A viewModel related to `HistoryDetailsViewController`
 *
 ******************************************************************************/

final class HistoryDetailsViewModel: HistoryDetailsViewModelProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  var call: CallModel? {
    didSet {
      shouldUpdateTitle?(navigationBarTitle)
    }
  }

  private let defaultNavigationBarTitle = "Call information"

  private var navigationBarTitle: String {
    guard let call = call, let date = Date(fromISO8601: call.createdAt) else {
      return defaultNavigationBarTitle
    }

    return "\(date.monthDayShortFormat), \(date.timeIn24HourFormat)"
  }

  let placeholderText = "Please select a call"

  /******************** Callbacks ********************/

  var shouldUpdateTitle: ((String) -> Void)?


  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

  func addNote() {

  }

  func tag() {

  }

  func assign() {

  }

}
