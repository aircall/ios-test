//
//  CallsContainer.swift
//  Aircall_iOS
//
//  Created by Jobert on 23/06/2021.
//

import Data
import Domain
import Foundation
import Networking
import Presentation
import UIKit

class CallsContainer {

    struct Dependencies {
        let apiDataTransferService: DataTransfer
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases
    var listCallsUseCase: ListCallsUseCase {
        DefaultListCallsUseCase(callsRepository: callsRepository)
    }

    var archivingCallUseCase: ArchivingCallUseCase {
        DefaultArchivingCallUseCase(callsRepository: callsRepository)
    }

    // MARK: - Data Sources
    var callsRepository: CallsRepository {
        DefaultCallsRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    // MARK: - Calls List
    var callsListViewController: UIViewController {
        ViewControllerFactory.createCallsListViewController(with: callsListViewModel, factory: self)
    }

    var callsListViewModel: CallsListViewModel {
        CallsListViewModel(listCallsUseCase: listCallsUseCase,
                           archivingCallUseCase: archivingCallUseCase)
    }

    // MARK: - Call Details
    func callDetailsViewModel(with call: Call) -> CallDetailsViewModel {
        CallDetailsViewModel(archivingCallUseCase: archivingCallUseCase, call: call)
    }
}

extension CallsContainer: CallsListViewControllersFactory {
    func makeCallDetailsViewController(for call: Call) -> UIViewController {
        ViewControllerFactory.createCallsDetailViewController(with: callDetailsViewModel(with: call))
    }
}
