//
//  HistoryDetailsViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 25/04/2021.
//

import Foundation

final class HistoryDetailsViewModel {

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
