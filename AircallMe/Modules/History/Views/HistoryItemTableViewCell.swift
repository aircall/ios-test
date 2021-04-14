//
//  HistoryItemTableViewCell.swift
//  History
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit

/// Table View cell to display history item information based on a view model
public final class HistoryItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
}

extension HistoryItemTableViewCell {
    func configure(model: HistoryCellVM) {
        leftImage.image = model.directionImage
        leftImage.tintColor = model.directionTintColor
        mainLabel.text = model.mainLabel
        secondLabel.text = model.secondLabel
        dateLabel.text = model.dateLabel
        hourLabel.text = model.hourLabel
        accessoryType = model.displayInfoButton ? .detailButton : .none
    }
}
