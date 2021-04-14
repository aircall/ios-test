//
//  Coordinator.swift
//  Common
//
//  Created by Rudy Frémont on 11/04/2021.
//

import UIKit
import Swinject

/// Basic class for Coordinator pattern
open class Coordinator {
    /// Keep a resolver to resolve dependency in coordinators
    public let resolver: Resolver
    
    public init(_ resolver: Resolver) {
        self.resolver = resolver
    }
    open weak var navigationController: UINavigationController?
}

/// Protocol for a root coordinator - root coordinator has to provide an access for its rootViewController
public protocol RootCoordinator: class {
    var rootViewController: UIViewController? { get }
}
