//
//  Endpoint.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation

enum EndPoint: CustomStringConvertible {
  case activities
  case activitiesBy(id: Int)
  case archiveActivity(id: Int)
  case resetCalls

  var description: String {
    switch self {
      case .activities: return "/activities"
      case .activitiesBy(let id): return "/activitiesBy/\(id)"
      case .archiveActivity(let id): return "/activities/\(id)"
      case .resetCalls: return "/reset"
    }
  }

}
