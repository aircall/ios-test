//
//  CallsListViewControllersFactory.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import Foundation
import UIKit

public protocol CallsListViewControllersFactory {
    func makeCallDetailsViewController(for call: Call) -> UIViewController
}
