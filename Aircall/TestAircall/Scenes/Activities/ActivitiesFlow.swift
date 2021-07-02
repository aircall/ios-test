//
//  ActivitiesFlow.swift
//  TestAircall
//
//  Created by Delphine Garcia on 01/07/2021.
//

import Foundation

enum ActivitiesFlow {
    
    enum ViewState {
        case loading
        case result
        case error
        case noData
    }
    
    enum CellState {
        case loading
        case result(ActivityUI)
    }
    
    enum ArchiveState {
        case pending
        case ok
        case error
    }
}
