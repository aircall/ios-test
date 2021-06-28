//
//  Activity.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 25/06/2021.
//

import Foundation
import UIKit

class Activity: OutputDecodable {
  let id: Int
  let createdAt: Date
  let direction: Direction
  let from: String?
  let to: String?
  let via: String?
  let duration: String
  var isArchived: Bool
  let callType: CallType

  init(id: Int,
       createdAt: Date,
       direction: Direction,
       from: String?,
       to: String?,
       via: String?,
       duration: String,
       isArchived: Bool,
       callType: CallType) {
    self.id = id
    self.createdAt = createdAt
    self.direction = direction
    self.from = from
    self.to = to
    self.via = via
    self.duration = duration
    self.isArchived = isArchived
    self.callType = callType
  }
}

enum Direction: String, Codable {
  case inbound, outbound

  var image: UIImage {
    switch self {
    case .inbound: return UIImage(systemName: "phone.arrow.down.left")!
    case .outbound: return UIImage(systemName: "phone.arrow.up.right")!
    }
  }

  var prefix: String {
    switch self {
    case .inbound: return "on"
    case .outbound: return "made by"
    }
  }
}

enum CallType: String, Codable {
  case answered, missed, voicemail

  var color: UIColor {
    switch self {
    case .answered: return .label
    case .missed: return .systemRed
    case .voicemail: return .systemTeal
    }
  }
}

extension Activity: Equatable {

  static func == (lhs: Activity, rhs: Activity) -> Bool {
    return lhs.id == rhs.id
      && lhs.createdAt == rhs.createdAt
      && lhs.direction == rhs.direction
      && lhs.from == rhs.from
      && lhs.to == rhs.to
      && lhs.via == rhs.via
      && lhs.duration == rhs.duration
      && lhs.isArchived == rhs.isArchived
      && lhs.callType == rhs.callType
  }
}
