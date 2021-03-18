//
//  Activity.swift
//  Aircall
//
//  Created by Ravichandrane Rajendran on 18/03/2021.
//

import Foundation

struct Activity: Codable {
  let id: Int
  let created_at: String
  let direction: CallDirectionType
  let from: String
  let to: String?
  let via: String
  let duration: String
  let is_archived: Bool
  let call_type: CallType
}
