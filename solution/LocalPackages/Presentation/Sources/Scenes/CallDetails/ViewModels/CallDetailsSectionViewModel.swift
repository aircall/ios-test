//
//  CallDetailsSectionViewModel.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Foundation

public enum CallDetailsSectionFooterType {
    case none
    case actions
}

public struct CallDetailsSectionViewModel: Identifiable {
    public let id = UUID()
    public let title: String
    public let details: String?
    public let items: [CallDetailsItemViewModel]
    public let footerType: CallDetailsSectionFooterType

    init(title: String,
         details: String? = nil,
         items: [CallDetailsItemViewModel] = [],
         footerType: CallDetailsSectionFooterType = .none) {
        self.title = title
        self.details = details
        self.items = items
        self.footerType = footerType
    }
}
