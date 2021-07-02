//
//  Alertable.swift
//  TestAircall
//
//  Created by Delphine Garcia on 04/07/2021.
//

import Foundation
import UIKit

protocol Alertable {
    func presentAlert(title: String?, message: String?, defaultButtonTitle: String?, completion: (() -> Void)?)
}

extension Alertable where Self: UIViewController {
    
    func presentAlert(title: String?, message: String?, defaultButtonTitle: String? = "Ok".localized, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: defaultButtonTitle, style: .default, handler: { (action) in
            completion?()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
