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

protocol AircallRestDataSource {
    func findActivities() -> AnyPublisher<[Call], Error>
    func saveActivity(call: Call) -> AnyPublisher<Void, Error>
}

class AircallRestClient: AircallRestDataSource {
    private let session: URLSession
    private let baseURL: URL
    private lazy var encoder: JSONEncoder = {
        var encoder = JSONEncoder()
        
        encoder.dateEncodingStrategy = .aircallFormat()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return encoder
    }()
    private lazy var decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .aircallFormat()
        
        return decoder
    }()
    
    init(session: URLSession = .shared, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }
    
    static func `default`() -> AircallRestClient {
        AircallRestClient(baseURL: URL(string: "https://aircall-job.herokuapp.com")!)
    }
    
    func findActivities() -> AnyPublisher<[Call], Error> {
        return session
            .dataTaskPublisher(for: AircallRestEndpoint.activities.url(relativeTo: baseURL))
            .validate()
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
                .validate()
                .map { _ in () }
                .eraseToAnyPublisher()
        }
        catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

extension JSONDecoder.DateDecodingStrategy {
    fileprivate static func aircallFormat() -> Self {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
        return .custom { decoder in
            let container = try decoder.singleValueContainer()
        
            guard let date = try formatter.date(from: container.decode(String.self)) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: [],
                        debugDescription: "Date is not valid format")
                )
            }
            
            return date
        }
    }
}

extension JSONEncoder.DateEncodingStrategy {
    fileprivate static func aircallFormat() -> Self {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        return .custom { date, encoder in
            var container = encoder.singleValueContainer()
            
            try container.encode(formatter.string(from: date))
        }
    }
}
