//
//  NetworkConstants.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 27/06/2021.
//

import Foundation

struct Network {

  struct URL: Hashable {
    static let scheme = "https"
    static let host = "aircall-job.herokuapp.com"
  }

  static let httpHeaders = [
    "Content-Type": "application/json"
  ]
}
