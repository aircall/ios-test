//
//  AppearanceACM.swift
//  CommonUI
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit

/// Utility class to apply appaerance settings
public class AppearanceACM {

    ///Entry point to set all appearance
    public static func setUpAppearance() {
        
        UIApplication.shared.delegate?.window??.tintColor = R.color.accentColor()
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = R.color.accentColor()
        UITabBar.appearance().tintColor = R.color.accentColor()
    }
}
