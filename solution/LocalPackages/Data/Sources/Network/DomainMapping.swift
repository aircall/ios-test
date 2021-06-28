//
//  DomainMapping.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Common
import Domain
import Foundation

extension Call {

    /**
     Maps a `CallResponse` to a `Call`.
     - Parameters:
        - call: An instance of `CallResponse`
     - Returns: An instance of `Call` if it succeeds to map, otherwise `nil`.
     */
    static func map(_ call: CallResponse) -> Call? {
        guard let direction: CallDirection = .map(call.direction),
              let type: CallType = .map(call.type) else {
            Log.shared.log("Failed to map response to domain mondel", level: .error)
            return nil
        }
        let call = Call(id: call.id,
                        createdAt: call.createdAt,
                        direction: direction,
                        from: call.from,
                        to: call.to,
                        via: call.via,
                        duration: call.duration,
                        isArchived: call.isArchived,
                        type: type)
        return call
    }
}

extension CallDirection {
    /**
     Maps a `CallDirectionResponse` to a `CallDirection`.
     - Parameters:
        - direction: An instance of `CallDirectionResponse`
     - Returns: An instance of `CallDirection` if it succeeds to map, otherwise `nil`.
     */
    static func map(_ direction: CallDirectionResponse) -> CallDirection? {
        CallDirection(rawValue: direction.rawValue)
    }
}

extension CallType {
    /**
     Maps a `CallTypeResponse` to a `CallType`.
     - Parameters:
        - direction: An instance of `CallTypeResponse`
     - Returns: An instance of `CallType` if it succeeds to map, otherwise `nil`.
     */
    static func map(_ type: CallTypeResponse) -> CallType? {
        CallType(rawValue: type.rawValue)
    }
}
