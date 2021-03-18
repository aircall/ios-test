//
//  Activity.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation

/// Activity Model
/// Model is used to retrieve all activities or single activity
struct Activity: Codable {
  let id: Int
  let created: String
  let direction: CallDirectionType
  let from: String
  let to: String?
  let via: String
  let duration: String
  let isArchived: Bool
  let callType: CallType

  /// Mapping remote model keys with local keys
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case created = "created_at"
    case direction = "direction"
    case from = "from"
    case to = "to"
    case via = "via"
    case duration = "duration"
    case isArchived = "is_archived"
    case callType = "call_type"
 }

  /// Decoding from the given decoder
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    created = try container.decode(String.self, forKey: .created)
    direction = try container.decode(CallDirectionType.self, forKey: .direction)
    from = try container.decode(String.self, forKey: .from)
    to = try? container.decode(String.self, forKey: .to)
    via = try container.decode(String.self, forKey: .via)
    duration = try container.decode(String.self, forKey: .duration)
    isArchived = try container.decode(Bool.self, forKey: .isArchived)
    callType = try container.decode(CallType.self, forKey: .callType)
  }
}
