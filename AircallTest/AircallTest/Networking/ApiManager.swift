//
//  ApiManager.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation
import Combine

protocol ApiManagerType {
    func getActivities(completion: @escaping(Result<Activities, Error>) -> Void)
    func getActivity(id: Int, completion: @escaping(Result<Activity, Error>) -> Void)
    func archiveActivity(id: Int, completion: @escaping(Result<Activity, Error>) -> Void)
}

class ApiManager: ApiManagerType {
    private let baseUrl = "aircall-job.herokuapp.com"
    private var subscriber = Set<AnyCancellable>()
    
    func getActivities(completion: @escaping(Result<Activities, Error>) -> Void) {
        perform(endpoint: .activities, completion: completion)
    }
    
    func getActivity(id: Int, completion: @escaping(Result<Activity, Error>) -> Void) {
        let endpoint = ApiEndpoint.activity(id: id)
        perform(endpoint: endpoint, completion: completion)
    }
    
    func archiveActivity(id: Int, completion: @escaping (Result<Activity, Error>) -> Void) {
        let body = ["is_archived": true]
        let endpoint = ApiEndpoint.archiveActivity(id: id, body: body)
        perform(endpoint: endpoint, completion: completion)
    }
}

extension ApiManager {
    private func perform<T: Decodable>(endpoint: ApiEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endpoint.request?.getUrlRequest(base: baseUrl) else {
            return
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { result in
                completion(.success(result))
            }
            .store(in: &subscriber)
    }
}
