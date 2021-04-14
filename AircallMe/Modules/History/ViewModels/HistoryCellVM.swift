//
//  HistoryCellVM.swift
//  History
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit
import Wordings
import CommonUI

/// Extension for Direction to get image and color for each possible Direction value
extension Direction {
    var directionImage: UIImage? {
        switch self {
        case .inbound:
            return UIImage(systemName: "phone.arrow.down.left")
        case .outbound:
            return UIImage(systemName: "phone.arrow.up.right")
        }
    }
    
    var directionTintColor: UIColor {
        switch self {
        case .inbound:
            return .systemRed
        case .outbound:
            return .systemGreen
        }
    }
}

/// View model to give text - colors - image and other informations for the table view cell view for an History model for each possible kind of view
enum HistoryCellVM {
    case list(HistoryModel)
    case contact(HistoryModel)
    case callType(HistoryModel)
    case callFrom(HistoryModel)
    
    // Helper to retrieve the model of the view model
    var model: HistoryModel {
        switch self {
        case .list(let value):
            return value
        case .contact(let value):
            return value
        case .callType(let value):
            return value
        case .callFrom(let value):
            return value
        }
    }
    
    var identifier: Int {
        return model.id
    }
    
    var directionImage: UIImage? {
        
        switch self {
        case .list:
            return model.direction.directionImage
        case .contact:
            return UIImage(systemName: "person.crop.circle")
        case .callType:
            return model.direction.directionImage
        case .callFrom:
            return UIImage(systemName: "flag.circle")
        }
    }
    
    var directionTintColor: UIColor {
        
        switch self {
        case .list:
            return model.direction.directionTintColor
        case .contact:
            return CommonUI.R.color.accentColor()!
        case .callType:
            return model.direction.directionTintColor
        case .callFrom:
            return CommonUI.R.color.accentColor()!
        }
    }

    var mainLabel: String? {
        
        switch self {
        case .list:
            switch model.direction {
            case .inbound:
                return model.from
            case .outbound:
                return model.to ?? LocalizedWords.historyDefaultFromToValueText()
            }
        case .contact:
            switch model.direction {
            case .inbound:
                return model.to ?? LocalizedWords.historyDefaultFromToValueText()
            case .outbound:
                return model.from
            }
        case .callType:
            switch model.callType {
            case .answered:
                return LocalizedWords.historyDetailIncommingCallAnswer()
            case .missed:
                return LocalizedWords.historyDetailIncommingCallMissed()
            case .voicemail:
                return LocalizedWords.historyDetailIncommingCallVoicemail()
            }
        case .callFrom:
            return model.via
        }
    }
    
    var secondLabel: String? {
        
        switch self {
        case .list:
            switch model.direction {
            case .inbound:
                return LocalizedWords.historyListModelInboundTo(model.to ?? LocalizedWords.historyDefaultFromToValueText())
                
            case .outbound:
                return LocalizedWords.historyListModelOutboundBy(model.from)
            }
        case .contact:
            return LocalizedWords.historyDetailContactInformationFrench()
        case .callType:
            switch model.callType {
            case .answered:
                return nil
            case .missed:
                return LocalizedWords.historyDetailIncommingCallMissedDetail()
            case .voicemail:
                return nil
            }
        case .callFrom:
            switch model.direction {
            case .inbound:
                return model.from
            case .outbound:
                return model.to ?? LocalizedWords.historyDefaultFromToValueText()
            }
        }
    }
    
    var dateLabel: String? {
        if case .list = self {
            return model.createdAt?.dayMonth()
        }
        return nil
    }
    
    var hourLabel: String? {
        if case .list = self {
            return model.createdAt?.timeShort()
        }
        return nil
    }
    
    var durationLabel: String {
        let duration: TimeInterval = Double(model.duration) ?? 0

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [ .minute, .second ]

        return formatter.string(from: duration) ?? "??"
    }
    
    var displayInfoButton: Bool {
        switch self {
        case .list:
            return true
        case .contact:
            return true
        case .callType:
            return false
        case .callFrom:
            return false
        }
    }
}
