//
//  Mock.swift
//  HistoryTests
//
//  Created by Rudy Frémont on 12/04/2021.
//

import Foundation
@testable import History
import Networking
import Common
import SwinjectDynamic
import Swinject

/// Mock class for UrlFactory protocol
struct MockUrlFactory: UrlFactory {
    
    func url() -> URL {
        return URL(string: "http://google.com")!
    }
    
    func method() -> RestMethod {
        return .get
    }
    
    func body() -> Data? {
        return nil
    }
}

/// Mock class for APIRequest protocol
class MockAPIRequest: APIRequest {
    
    var nextData: Data?
    var nextStatusCode: HTTPStatusCode? = .ok
    
    func sendRequest(requestFactory: UrlFactory, completion: @escaping (Data?, HTTPStatusCode?) -> Void) {
        completion(nextData, nextStatusCode)
    }
    func cancelRequests() {}
}

/// Mock data constructor
enum MockData {

    case oneItem
    case tenItem
    case tenItemArchived
    
    var data: Data? {
        switch self {
        case .oneItem:
            return try? fakeModel(archive: false).encode()
        case .tenItem:
            var models: [HistoryModel] = []
            
            for _ in 1...10 {
                models.append(fakeModel(archive: false))
            }
            
            return try? models.encode()
        case .tenItemArchived:
            var models: [HistoryModel] = []
            
            for _ in 1...10 {
                models.append(fakeModel(archive: true))
            }
            
            return try? models.encode()
        }
    }
    
    func fakeModel(archive: Bool = false) -> HistoryModel {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2021/05/05 14:30")
        
        return HistoryModel(id: 1,
                            createdAt: someDateTime,
                            direction: .inbound,
                            from: "A",
                            to: "B",
                            via: "C",
                            duration: "1",
                            isArchived: archive,
                            callType: .answered)
    }
    
    func fakeModelWithoutDate(archive: Bool = false) -> HistoryModel {

        return HistoryModel(id: 1,
                            createdAt: nil,
                            direction: .inbound,
                            from: "A",
                            to: "B",
                            via: "C",
                            duration: "1",
                            isArchived: archive,
                            callType: .answered)
    }
    
}

/// Mock class for Depency injection
class MockDependencyProvider {
    
    var resolver: Resolver {
        assembler.resolver
    }

    private let container = Container()
    private let assembler: Assembler

    init() {
        // the assembler gathers all the dependencies in one place
        assembler = Assembler(
            [
                Networking.NetworkingAssembly(),
                History.HistoryAssembly()
            ],
            container: container
        )
    }
}
