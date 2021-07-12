//
//  ViewModelType.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 09/07/2021.
//

import Foundation

protocol LoadableViewModelType: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}
