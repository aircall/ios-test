//
//  HistoryDetailFooterViewVM.swift
//  History
//
//  Created by Rudy Frémont on 11/04/2021.
//

import UIKit
import Wordings

/// View model for History Detail action panel - give all necessary information about the view
final class HistoryDetailFooterViewVM {
    
    var notesActionTitle: String {
        LocalizedWords.historyDetailActionNotesTitle()
    }
    
    var notesActionImage: UIImage {
        UIImage(systemName: "pencil.tip.crop.circle")!
    }
    
    var tagsActionTitle: String {
        LocalizedWords.historyDetailActionTagsTitle()
    }
    
    var tagsActionImage: UIImage {
        UIImage(systemName: "tag")!
    }
    
    var assignActionTitle: String {
        LocalizedWords.historyDetailActionAssignTitle()
    }
    
    var assignActionImage: UIImage {
        UIImage(systemName: "person.badge.plus")!
    }
    
    var copyCallIDActionTitle: String {
        LocalizedWords.historyDetailActionCopyCallIdTitle()
    }

}
