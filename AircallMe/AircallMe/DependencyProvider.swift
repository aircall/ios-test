//
//  DependencyProvider.swift
//  AircallMe
//
//  Created by Rudy Frémont on 11/04/2021.
//

import Foundation
import History
import Networking
import Swinject

final class DependencyProvider {
    
    /// resolver can resolve all dependencies from the DependencyManager
    var resolver: Resolver {
        assembler.resolver
    }

    /// Dependencies container
    private let container = Container()
    
    /// Dependencies assembler that call all sub assembly class to get their dependencies
    private let assembler: Assembler

    init() {
        
        // the assembler gathers all the dependencies in one place (the container)
        assembler = Assembler(
            [
                Networking.NetworkingAssembly(),
                History.HistoryAssembly()
            ],
            container: container
        )
    }
}
