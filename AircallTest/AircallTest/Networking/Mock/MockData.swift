//
//  MockData.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation

#if DEBUG
extension Activities {
    static let mockedData: Activities = [
        Activity(id: 7834,
                 createdAt: "2018-04-19T09:38:41.000Z".iso8601Date() ?? Date(),
                 direction: .outbound,
                 from: "Michel Drucker",
                 to: "06 46 62 12 33",
                 via: "France 2",
                 duration: "120",
                 isArchived: false,
                 callType: .missed),
        Activity(id: 7833,
                 createdAt: "2018-04-19T09:38:41.000Z".iso8601Date() ?? Date(),
                 direction: .inbound,
                 from: "Johnny Halliday",
                 to: "06 45 13 53 91",
                 via: "Universal Music",
                 duration: "60",
                 isArchived: false,
                 callType: .answered),
        Activity(id: 7832,
                 createdAt: "2018-04-18T16:53:22.000Z".iso8601Date() ?? Date(),
                 direction: .inbound,
                 from: "Support FR",
                 to: "06 46 62 12 33",
                 via: "France 2",
                 duration: "120",
                 isArchived: false,
                 callType: .voicemail)
    ]
}

extension Activity {
    static var mockedData: Activity {
        return Activity(id: 7834,
                        createdAt: "2018-04-19T09:38:41.000Z".iso8601Date() ?? Date(),
                        direction: .outbound,
                        from: "Michel Drucker",
                        to: "06 46 62 12 33",
                        via: "France 2",
                        duration: "120",
                        isArchived: false,
                        callType: .missed)
    }
}

#endif
