//
//  AircallDataSource.swift
//  Aircall
//
//  Created by JC on 19/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine

enum AircallRestEndpoint {
    case activities
    case activity(Call)
    
    var path: String {
        switch self {
        case .activities:
            return "activities"
        case .activity(let call):
            return "activities/\(call.id)"
        }
    }
    
    func url(relativeTo url: URL) -> URL {
        URL(string: path, relativeTo: url)!
    }
}

class AircallRestDataSource {
    private let session: URLSession
    private let baseURL: URL
    private lazy var encoder: JSONEncoder = {
        var encoder = JSONEncoder()
        
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return encoder
    }()
    private lazy var decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }()
    
    init(session: URLSession = .shared, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func findActivities() -> AnyPublisher<[Call], Error> {
        return session
            .dataTaskPublisher(for: AircallRestEndpoint.activities.url(relativeTo: baseURL))
            .map(\.data)
            .decode(type: [Call].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func saveActivity(call: Call) -> AnyPublisher<Void, Error> {
        do {
            let request = try URLRequest(url: AircallRestEndpoint.activity(call).url(relativeTo: baseURL))
                .body(call, encoder: encoder)
            
            return session
                .dataTaskPublisher(for: request)
                .eraseToAnyPublisher()
                .eraseToAnyError()
        }
        catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

extension URLRequest {
    func body<Item: Encodable, Encoder: TopLevelEncoder>(_ body: Item, encoder: Encoder) throws -> Self
        where Encoder.Output == Data {
            var request = self
            
            request.httpMethod = "POST"
            request.httpBody = try encoder.encode(body)
            
            return request
    }
}

extension AnyPublisher {
    func eraseToAnyError() -> AnyPublisher<Output, Error> {
        mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

extension URLSession.DataTaskPublisher {
    /// An AnyPublisher also return types
    public func eraseToAnyPublisher() -> AnyPublisher<Void, URLError> {
        self
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
