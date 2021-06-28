//
//  CallsListViewRouting.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import Foundation

public enum CallsListViewRoute {
    case showDetail(ofCall: Call)
}

public protocol CallsListViewRouter {
    func perform(_ route: CallsListViewRoute)
}
