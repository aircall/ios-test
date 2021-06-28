//
//  MockedEntities.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

@testable import Domain
import Foundation

struct MockedEntities {
    static let calls =
        [Call(id: 7834,
              createdAt: Date(timeIntervalSince1970: 1524130721.0),
              direction: .outbound,
              from: "Pierre-Baptiste Béchu",
              to: "06 46 62 12 33",
              via: "NYC Office",
              duration: "120",
              isArchived: true,
              type: .missed),
         Call(id: 7833,
              createdAt: Date(timeIntervalSince1970: 1524070788.0),
              direction: .outbound,
              from: "Jonathan Anguelov",
              to: "06 45 13 53 91",
              via: "NYC Office",
              duration: "60",
              isArchived: false,
              type: .missed),
         Call(id: 7832,
              createdAt: Date(timeIntervalSince1970: 1524070402.0),
              direction: .inbound,
              from: "06 19 18 23 92",
              to: "Jonathan Anguelov",
              via: "Support FR",
              duration: "180",
              isArchived: false,
              type: .answered),
         Call(id: 7831,
              createdAt: Date(timeIntervalSince1970: 1524069775.0),
              direction: .inbound,
              from: "06 34 45 74 34",
              to: "Xavier Durand",
              via: "Support FR",
              duration: "180",
              isArchived: false,
              type: .answered),
         Call(id: 7830,
              createdAt: Date(timeIntervalSince1970: 1524068623.0),
              direction: .inbound,
              from: "+33 6 34 45 74 34",
              to: nil,
              via: "Support FR",
              duration: "120",
              isArchived: false,
              type: .voicemail),
         Call(id: 7829,
              createdAt: Date(timeIntervalSince1970: 1524066212.0),
              direction: .inbound,
              from: "+33 6 34 45 74 34",
              to: "Olivier Pailhes",
              via: "Spain Hotline",
              duration: "300",
              isArchived: false,
              type: .answered)]
}
