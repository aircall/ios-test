//
//  SceneDelegate.swift
//  AircallMe
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit
import CommonUI
import Common

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    /// The window for application
    var window: UIWindow?
    
    /// The  application coordinator
    private var appCoordinator: AppCoordinator?
    
    /// The provider for the dependency system
    private var dependencyProvider: DependencyProvider?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Apply generic configuration with appearance
        CommonUI.AppearanceACM.setUpAppearance()
        
        // Initialize dependency provider with swinject
        let provider = DependencyProvider()
        
        // Create the application coordinator
        appCoordinator = AppCoordinator()
        appCoordinator?.start(on: window!, with: provider.resolver)
        dependencyProvider = provider
        
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}
