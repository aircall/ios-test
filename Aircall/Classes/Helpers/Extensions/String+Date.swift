//
//  String+Date.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation

extension String {

  func getFormattedDate(format: String) -> String{
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateFormat = Constants.format

    if let date = formatter.date(from: self) {
      let outFormatter = DateFormatter()
      outFormatter.dateFormat = format
      return outFormatter.string(from: date)
    }

    return self
  }

}
