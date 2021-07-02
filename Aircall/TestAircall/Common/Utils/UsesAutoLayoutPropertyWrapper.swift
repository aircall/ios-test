//
//  UsesAutoLayoutPropertyWrapper.swift
//  TestAircall
//
//  Created by Delphine Garcia on 29/06/2021.
//

import UIKit

@propertyWrapper
public struct UsesAutoLayout<T: UIView> {
    
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
            wrappedValue.layer.masksToBounds = true
        }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        wrappedValue.layer.masksToBounds = true
    }
}
