//
//  Call+CoreDataProperties.swift
//  AircallLaurent
//
//  Created by Laurent on 30/04/2021.
//
//

import Foundation
import CoreData


extension Call {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Attributes ********************/

  @NSManaged public var callType: String?
  @NSManaged public var createdAt: String?
  @NSManaged public var direction: String?
  @NSManaged public var duration: String?
  @NSManaged public var id: Int32
  @NSManaged public var isArchived: Bool
  @NSManaged public var receiver: String?
  @NSManaged public var sender: String?

  /******************** FetchRequests ********************/

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Call> {
    return NSFetchRequest<Call>(entityName: "Call")
  }

  //----------------------------------------------------------------------------
  // MARK: - Configuration
  //----------------------------------------------------------------------------

  func configure(from call: CallModel) {
    callType = call.callType.rawValue
    createdAt = call.createdAt
    direction = call.direction.rawValue
    duration = call.duration
    id = Int32(call.id)
    isArchived = call.isArchived
    receiver = call.receiver
    sender = call.sender
  }
}

extension Call : Identifiable {

}
