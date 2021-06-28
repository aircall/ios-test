//
//  ActivityConfigurableCell.swift
//  Aircall-iOS-Test
//
//  Created by Jerome BOURSIER on 26/06/2021.
//

import UIKit

protocol ActivityConfigurableCell where Self: UITableViewCell {
  func configure(with activity: Activity)
}
