//
//  HistoryDetailVM.swift
//  History
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit
import Common
import Wordings

/// enum to describe how the detail screen section has to be displayed
private enum DetailSection {
    
    case contact
    case call(duration: String)
    
    func header() -> NSAttributedString {
        
        let boldFont = UIFont.preferredFont(forTextStyle: .headline)
        let normalFont = UIFont.preferredFont(forTextStyle: .footnote)

        switch self {
        case .contact:
            return NSMutableAttributedString(string: LocalizedWords.historyDetailContactInformationText(),
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.label,
                                                          NSAttributedString.Key.font: boldFont])
        case .call(let duration):
            //Create attributed string with text and default attributes
            let newAttr = NSMutableAttributedString(string: LocalizedWords.historyDetailCallInformationText(),
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.label,
                                                                 NSAttributedString.Key.font: boldFont])
            let durationAttr = NSMutableAttributedString(string: " (\(duration))",
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                 NSAttributedString.Key.font: normalFont])
            newAttr.append(durationAttr)
            return newAttr
        }
    }
    
    func itemsCount() -> Int {
        switch self {
        case .contact:
            return 1
        case .call:
            return 2
        }
    }
    
    func modelForRow(_ indexPath: IndexPath, model: HistoryModel) -> HistoryCellVM {
        switch self {
        case .contact:
            return .contact(model)
        case .call:
            if 0 == indexPath.row {
                return .callType(model)
            }
            return .callFrom(model)
        }
    }
}

/// View model for History Detail view controller - give all necessary information and action method about the screen
final class HistoryDetailVM {
    
    private let historyServices: HistoryServices
    
    private var detailData: [DetailSection] = []
    
    let historyModel: HistoryModel
    
    init(historyModel: HistoryModel, historyService: HistoryServices) {
        historyServices = historyService
        self.historyModel = historyModel
        detailData = [.contact, .call(duration: HistoryCellVM.list(historyModel).durationLabel)]
    }
    
    var title: String? {
        
        let model = HistoryCellVM.list(historyModel)
        if let date = model.dateLabel,
           let time = model.hourLabel {
            return date + ", " + time
        }
        return nil
    }
    
    func sectionsCount() -> Int {
        return detailData.count
    }
    
    func itemsCount(section: Int) -> Int {
        return detailData[section].itemsCount()
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HistoryCellVM {
        return detailData[indexPath.section].modelForRow(indexPath, model: historyModel)
    }
    
    func headerForSection(section: Int) -> NSAttributedString {
        return detailData[section].header()
    }
    
    /// Archive the history item
    /// - Parameter completion: completion result
    func archiveItem(completion: @escaping CompletionHandler<Void>) {
        
        let identifier = historyModel.id
        
        historyServices.archiveHistoryEntry(identifier: identifier) { result in
            switch result {
            case .success:
                completion(result)
            case .failure(let statusCode):
                print(statusCode.localizedDescription)
                completion(result)
            }
        }
    }
}
