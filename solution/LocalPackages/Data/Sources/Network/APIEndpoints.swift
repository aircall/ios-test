//
//  APIEndpoints.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Common
import Domain
import Foundation
import Networking

/**
 Stores all supported endpoints.
 */
struct APIEndpoints {

    /**
     The endpoint to get a list of all the calls.
     - Returns: An instance of `DataEndpoint` with an array of `CallResponse`.
     */
    static func calls() -> DataEndpoint<[CallResponse]> {
        DataEndpoint(path: "activities")
    }

    /**
     The endpoint to archive a call.
     - Parameters:
        - callId: The id of the call to archive.
        - archive: Tells whether to archive or not the call with the given id.
     - Returns: An instance of `DataEndpoint` with a `CallResponse`.
     */
    static func archiveCall(with callId: UInt, archive: Bool) -> DataEndpoint<CallResponse> {
        let request = CallArchivingRequest(isArchived: archive)
        let body = try? JSONEncoder().encode(request)
        return DataEndpoint(path: "activities/\(callId)",
                            method: .post,
                            body: body)
    }
}
