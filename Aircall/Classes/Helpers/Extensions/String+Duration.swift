//
//  String+Duration.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation

extension String {

  func getDuration() -> String {
    guard let duration = Int(self) else { return self }

    return duration > 60 ? "(\(duration / 60) min)" : "(\(duration) sec)"
  }

}
