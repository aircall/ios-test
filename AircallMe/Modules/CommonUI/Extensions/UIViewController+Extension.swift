//
//  UIViewController+Extension.swift
//  CommonUI
//
//  Created by Rudy Frémont on 10/04/2021.
//

import UIKit
import Wordings

private class CommonUIActivityIndicatorView: UIActivityIndicatorView {}

/// For every UIViewController we can display and hide an activity indicator centered in the current view by using startLoading / stopLoading
public extension UIViewController {

    func startLoading() {
        stopLoading()

        let loaderView = CommonUIActivityIndicatorView(style: .large)
        loaderView.color = R.color.accentColor()
        view.addSubview(loaderView)

        // Center loader in current view by using view.layoutMarginsGuide
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        loaderView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        loaderView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        loaderView.heightAnchor.constraint(equalToConstant: 36).isActive = true

        loaderView.startAnimating()
    }

    func stopLoading() {
        view.subviews.first { $0 is CommonUIActivityIndicatorView }?.removeFromSuperview()
    }
}

public extension UIViewController {

    ///Helper to display a generic alert with a Retry button
    func presentTechnicalAlertWithRetry(retryHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: LocalizedWords.commonTechnicalAlertTitle(),
                                      message: LocalizedWords.commonTechnicalAlertMessage(),
                                      preferredStyle: .alert)
        let cancelAlert = UIAlertAction(title: LocalizedWords.commonTechnicalAlertCancel(), style: .cancel, handler: nil)
        let retryAlert = UIAlertAction(title: LocalizedWords.commonTechnicalAlertRetry(), style: .default, handler: retryHandler)

        alert.addAction(retryAlert)
        alert.addAction(cancelAlert)
        alert.preferredAction = retryAlert
        present(alert, animated: true, completion: nil)
    }
}
