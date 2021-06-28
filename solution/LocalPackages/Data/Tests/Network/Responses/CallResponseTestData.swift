//
//  CallResponseTestData.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

@testable import Common
@testable import Data
import Foundation

struct CallResponseTestData {
    let sampleFile: FileDescription
    let expectedCalls: [CallResponse]
}

extension CallResponseTestData {

    static var activities: CallResponseTestData {
        let fileName = "sample_get_activities"
        guard let file = FileDescription.json(with: fileName) else {
            fatalError("Could not initialize sample JSON file named \(fileName)")
        }
        let testData = CallResponseTestData(sampleFile: file, expectedCalls: allCalls)
        return testData
    }

    static var activityDetails: CallResponseTestData {
        let fileName = "sample_activity_details"
        guard let file = FileDescription.json(with: fileName),
              let firstCall = allCalls.first else {
            fatalError("Could not initialize sample JSON file named \(fileName)")
        }
        let calls: [CallResponse] = [firstCall]
        let testData = CallResponseTestData(sampleFile: file, expectedCalls: calls)
        return testData
    }

    private static var allCalls: [CallResponse] {
        [CallResponse(id: 7834,
                      createdAt: Date(timeIntervalSince1970: 1524130721.0),
                      direction: .outbound,
                      from: "Pierre-Baptiste Béchu",
                      to: "06 46 62 12 33",
                      via: "NYC Office",
                      duration: "120",
                      isArchived: true,
                      type: .missed),
         CallResponse(id: 7833,
                      createdAt: Date(timeIntervalSince1970: 1524070788.0),
                      direction: .outbound,
                      from: "Jonathan Anguelov",
                      to: "06 45 13 53 91",
                      via: "NYC Office",
                      duration: "60",
                      isArchived: false,
                      type: .missed),
         CallResponse(id: 7832,
                      createdAt: Date(timeIntervalSince1970: 1524070402.0),
                      direction: .inbound,
                      from: "06 19 18 23 92",
                      to: "Jonathan Anguelov",
                      via: "Support FR",
                      duration: "180",
                      isArchived: false,
                      type: .answered),
         CallResponse(id: 7831,
                      createdAt: Date(timeIntervalSince1970: 1524069775.0),
                      direction: .inbound,
                      from: "06 34 45 74 34",
                      to: "Xavier Durand",
                      via: "Support FR",
                      duration: "180",
                      isArchived: false,
                      type: .answered),
         CallResponse(id: 7830,
                      createdAt: Date(timeIntervalSince1970: 1524068623.0),
                      direction: .inbound,
                      from: "+33 6 34 45 74 34",
                      to: nil,
                      via: "Support FR",
                      duration: "120",
                      isArchived: false,
                      type: .voicemail),
         CallResponse(id: 7829,
                      createdAt: Date(timeIntervalSince1970: 1524066212.0),
                      direction: .inbound,
                      from: "+33 6 34 45 74 34",
                      to: "Olivier Pailhes",
                      via: "Spain Hotline",
                      duration: "300",
                      isArchived: false,
                      type: .answered)]
    }
}
