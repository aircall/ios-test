//
//  HistoryAssembly.swift
//  History
//
//  Created by Rudy Frémont on 11/04/2021.
//

import UIKit
import Swinject
import Networking

/// Register History class in this Assembly for swinject
public final class HistoryAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        // Register Coordinators
        container.register(HistoryCoordinator.self) { (r, nav: UINavigationController) in
            return HistoryCoordinator(r, nav: nav)
        }
        container.register(HistoryDetailCoordinator.self) { r in
            return HistoryDetailCoordinator(r)
        }
        
        // Register services
        container.register(HistoryServices.self) { r in
            return HistoryServicesImpl(manager: r.resolve(APIRequest.self)!)
        }
        
        // Register VC
        container.register(HistoryListVC.self) { r in
            return HistoryListVC(style: .plain, viewmodel: r.resolve(HistoryListVM.self)!)
        }
        container.register(HistoryDetailVC.self) { (r, model: HistoryModel) in
            return HistoryDetailVC(style: .grouped, viewmodel: r.resolve(HistoryDetailVM.self, argument: model)!)
        }
        
        // Register VM
        container.register(HistoryDetailVM.self) { (r, model: HistoryModel) in
            return HistoryDetailVM(historyModel: model, historyService: r.resolve(HistoryServices.self)!)
        }
        
        container.register(HistoryListVM.self) { r in
            return HistoryListVM(historyService: r.resolve(HistoryServices.self)!)
        }
    }
}
