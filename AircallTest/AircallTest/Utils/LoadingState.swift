//
//  State.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation

/// Used when fetching data is needed
/// Allows the view to update its state if needed
/// Conform to Equatable protocol in order to perform tests
enum LoadingState<T>: Equatable {
    case idle
    case loading
    case failed(Error)
    case loaded(T)
    case empty
}

extension LoadingState {
    /// Equatable conformance
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.loaded(_), .loaded(_)): return true
        case (.failed(_), .failed(_)): return true
        case (.empty, .empty): return true
        default: return false
        }
    }
}
