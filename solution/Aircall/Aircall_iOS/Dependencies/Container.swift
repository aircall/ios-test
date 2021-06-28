//
//  Container.swift
//  Aircall_iOS
//
//  Created by Jobert on 23/06/2021.
//

import Common
import Foundation
import Networking
import Presentation
import UIKit

final class Container {

    lazy var config = AppConfig()

    lazy var apiDataTransferService: DataTransfer = {
        let config = APIDataNetworkConfig(baseURL: URL(string: config.apiBaseURL)!)
        let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                                   config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    var callsContainer: CallsContainer {
        CallsContainer(dependencies: .init(apiDataTransferService: apiDataTransferService))
    }

    init() {
        Appearance.setup()
    }
}
