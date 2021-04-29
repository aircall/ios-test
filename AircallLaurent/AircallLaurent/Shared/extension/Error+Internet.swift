//
//  Error+Internet.swift
//  AircallLaurent
//
//  Created by Laurent on 29/04/2021.
//

import Foundation

extension Error {

  /// Tell if the current error is related to a missing internet connection.
  var isNotConnectedToInternetError: Bool {
    let errorCode = (self as NSError).code
    return errorCode == NSURLErrorNotConnectedToInternet
  }

}
