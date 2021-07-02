//
//  ReusableView.swift
//  TestAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import Foundation

protocol ReusableView: class {}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
