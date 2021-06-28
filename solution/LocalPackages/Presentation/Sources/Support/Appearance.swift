//
//  Appearance.swift
//  
//
//  Created by Jobert on 26/06/2021.
//

import UIKit

public final class Appearance {
    public class func setup() {
        UINavigationBar.appearance().tintColor = .systemGreen
        UITableView.appearance().separatorInset = .zero
        UITableView.appearance().separatorInset = .zero
        UITableView.appearance().backgroundColor = .secondarySystemBackground.withAlphaComponent(0.2)
    }
}
