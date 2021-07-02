//
//  DataProvider.swift
//  NetworkingAircall
//
//  Created by Delphine Garcia on 25/06/2021.
//

import Foundation

public protocol DataProviderProtocol {
    func loadActivities(completion: @escaping (Result<[ActivityNWK], Error>) -> Void)
    func archiveActivity(id: Int, completion: @escaping (Error?) -> Void)
    func reset(completion: @escaping (Error?) -> Void)
}

public class DataProvider: DataProviderProtocol {
    
    private let service: ServerService
    private let decoder: Decoder
    
    public init(service: ServerService = UrlSessionService(), decoder: Decoder = JSONDecoder()) {
        self.service = service
        self.decoder = decoder
    }
    
    public func loadActivities(completion: @escaping (Result<[ActivityNWK], Error>) -> Void) {
        service.performRequest(EndPoint.getActivities) { [decoder] networkingResult in
            completion(decoder.decode(data: networkingResult))
        }
    }
    
    public func archiveActivity(id: Int, completion: @escaping (Error?) -> Void) {
        service.performRequest(EndPoint.archiveActivity(id: id)) { networkingResult in
            switch networkingResult {
            case .failure(let error):
                completion(error)
            default:
                completion(nil)
            }
        }
    }
    
    public func reset(completion: @escaping (Error?) -> Void) {
        service.performRequest(EndPoint.reset) { networkingResult in
            switch networkingResult {
            case .failure(let error):
                completion(error)
            default:
                completion(nil)
            }
        }
    }
}

public protocol Decoder {
    func decode<T: Decodable>(data: Result<Data, Error>) -> Result<T, Error>
}

extension JSONDecoder: Decoder {
    public func decode<T: Decodable>(data: Result<Data, Error>) -> Result<T, Error> {
        switch data {
        case .success(let networkingData):
            do {
                let decodedData = try self.decode(T.self, from: networkingData)
                return .success(decodedData)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
