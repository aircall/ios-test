//
//  CallModel.swift
//  AircallLaurent
//
//  Created by Laurent on 26/04/2021.
//

import Foundation

struct CallModel: Codable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let id: Int
  let createdAt: String
  let direction: Direction
  let sender: String
  let receiver: String?
  let phoneOperator: String
  let duration: String
  var isArchived: Bool
  let callType: CallType

  //----------------------------------------------------------------------------
  // MARK: - Coding keys
  //----------------------------------------------------------------------------

  enum CodingKeys: String, CodingKey {
    case id
    case createdAt = "created_at"
    case direction
    case sender = "from"
    case receiver = "to"
    case phoneOperator = "via"
    case duration
    case isArchived = "is_archived"
    case callType = "call_type"
  }

}
