//
//  Image+Utils.swift
//  AircallUI
//
//  Created by Patricio Guzman on 13/04/2021.
//

import SwiftUI

extension Image {
    init(systemName: SFSymbols) {
        self.init(systemName: systemName.rawValue)
    }
}
