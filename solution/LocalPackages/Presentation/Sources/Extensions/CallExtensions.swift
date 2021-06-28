//
//  CallExtensions.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import Foundation

extension Call {
    var directionSymbol: SFSymbol {
        switch direction {
        case .inbound: return .inboundCall
        case .outbound: return .outboundCall
        }
    }

    var status: CallStatus {
        switch type {
        case .answered: return .success
        default: return .failure
        }
    }

    var directionCallText: String {
        switch direction {
        case .inbound: return L10n.incomingCall
        case .outbound: return L10n.outcomingCall
        }
    }

    var detailedTypeDescription: String {
        switch status {
        case .success: return L10n.callDirectionAnswered(directionCallText)
        case .failure: return L10n.callDirectionMissed(directionCallText)
        }
    }

    var detailedStatusText: String {
        let actor = direction == .inbound ? L10n.caller : L10n.callee
        switch type {
        case .answered: return L10n.answeredBy(actor)
        case .missed: return L10n.abandonedBy(actor)
        case .voicemail: return L10n.notAnsweredBy(actor)
        }
    }
}
