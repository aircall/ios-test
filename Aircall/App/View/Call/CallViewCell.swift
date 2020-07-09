//
//  ActivityViewCell.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import UIKit
import Reusable

class CallViewCell: UITableViewCell, Reusable {
    @IBOutlet private var directionIcon: UIImageView!
    @IBOutlet private var fromLabel: UILabel!
    @IBOutlet private var callInfoLabel: UILabel!
    @IBOutlet private var callTimeLabel: UILabel!
    
    func bind(call: Call) {
        
    }
}
