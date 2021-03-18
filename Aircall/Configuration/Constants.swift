//
//  Constant.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation

struct Constants {

  static let format = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
  static var BaseURL: URL {
    guard let url = URL(string: "https://aircall-job.herokuapp.com") else { fatalError("BaseURL nil") }
    return url
  }

}
