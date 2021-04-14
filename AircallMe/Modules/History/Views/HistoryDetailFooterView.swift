//
//  HistoryDetailFooterView.swift
//  History
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit

/// View to display action panel in the history detail screen - based on a view model
public final class HistoryDetailFooterView: UIView {
    
    /// Create the view model when necessary
    private lazy var viewModel = HistoryDetailFooterViewVM()
    
    @IBOutlet weak var notesActionButton: HistoryDetailActionButton! {
        didSet {
            notesActionButton.setTitle(viewModel.notesActionTitle, for: [])
            notesActionButton.setImage(viewModel.notesActionImage, for: [])
            notesActionButton.tintColor = .black
        }
    }
    @IBOutlet weak var tagsActionButton: HistoryDetailActionButton! {
        didSet {
            tagsActionButton.setTitle(viewModel.tagsActionTitle, for: [])
            tagsActionButton.setImage(viewModel.tagsActionImage, for: [])
            tagsActionButton.tintColor = .black
        }
    }
    @IBOutlet weak var assignActionButton: HistoryDetailActionButton! {
        didSet {
            assignActionButton.setTitle(viewModel.assignActionTitle, for: [])
            assignActionButton.setImage(viewModel.assignActionImage, for: [])
            assignActionButton.tintColor = .black
        }
    }
    @IBOutlet weak var copyCallIDActionButton: UIButton! {
        didSet {
            copyCallIDActionButton.setTitle(viewModel.copyCallIDActionTitle, for: [])
        }
    }
}
