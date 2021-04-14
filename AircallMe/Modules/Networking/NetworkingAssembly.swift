//
//  NetworkingAssembly.swift
//  Networking
//
//  Created by Rudy Frémont on 11/04/2021.
//

import Foundation
import Swinject

/// Register Networking class in this Assembly for swinject
public final class NetworkingAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(APIRequest.self) { _ in
            
            // Create URLSession during the resolve step
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            let session = URLSession(configuration: config)
            return RequestManager(session: session)
        }.inObjectScope(.weak)
    }
}
