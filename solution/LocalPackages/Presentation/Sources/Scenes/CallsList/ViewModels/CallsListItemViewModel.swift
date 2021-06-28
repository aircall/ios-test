//
//  CallsListItemViewModel.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation
import Common
import Domain

public struct CallsListItemViewModel: Identifiable {
    public var id: UInt { call.id }
    let call: Call

    var callDirection: SFSymbol { call.directionSymbol }
    var status: CallStatus { call.status }
    var caller: String { getCallerInfo() }
    var formattedInfo: String { getFormattedInfo() }
    var formattedDate: String { getFormattedDate() }
    var formattedTime: String { getFormattedTime() }

    init(_ call: Call) {
        self.call = call
    }

    public func archiveCall() {
    }

    private func getCallerInfo() -> String {
        call.from
    }

    private func getFormattedInfo() -> String {
        switch call.direction {
        case .inbound: return L10n.madeByCaller(call.from)
        case .outbound: return L10n.onCallee(call.from)
        }
    }

    private func getFormattedDate() -> String {
        DateFormatter.monthDay.string(from: call.createdAt)
    }

    private func getFormattedTime() -> String {
        DateFormatter.time.string(from: call.createdAt)
    }
}
