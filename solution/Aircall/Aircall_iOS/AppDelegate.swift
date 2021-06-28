//
//  AppDelegate.swift
//  Aircall_iOS
//
//  Created by Jobert on 23/06/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let container = Container()
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = container.callsContainer.callsListViewController
        window?.makeKeyAndVisible()

        return true
    }
}
