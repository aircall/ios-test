//
//  Loadable.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation

public enum Loadable<T> {
    case notRequested
    case isLoading
    case loaded(T)
    case failed(error: Error)
}
