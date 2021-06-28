//
//  CallInfoStatsViewModel.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import Foundation

public class CallInfoStatsViewModel: CallDetailsItemViewModel {
    let callDirection: SFSymbol
    let status: CallStatus
    let detailedDescription: String
    let detailedStatus: String

    init(_ call: Call) {
        callDirection = call.directionSymbol
        status = call.status
        detailedDescription = call.detailedTypeDescription
        detailedStatus = call.detailedStatusText
    }
}
