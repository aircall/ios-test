//
//  SceneDelegate.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  //----------------------------------------------------------------------------
  // MARK: - Propertie
  //----------------------------------------------------------------------------

  var window: UIWindow?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private func setupWindows(with windowScene: UIWindowScene) {
    window = UIWindow(windowScene: windowScene)
    window?.isOpaque = true
//    window?.rootViewController =
    window?.backgroundColor = .black
    window?.makeKeyAndVisible()
  }

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    setupWindows(with: windowScene)
  }

  func sceneDidDisconnect(_ scene: UIScene) {
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
  }

  func sceneWillResignActive(_ scene: UIScene) {
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }

}

