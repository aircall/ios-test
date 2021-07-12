//
//  MockApiManager.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

class MockApiManager: ApiManagerType {
    func getActivities(completion: @escaping(Result<Activities, Error>) -> Void) {
        completion(.success(Activities.mockedData))
    }
    
    func getActivity(id: Int, completion: @escaping(Result<Activity, Error>) -> Void) {
        completion(.success(Activity.mockedData))
    }
    
    func archiveActivity(id: Int, completion: @escaping (Result<Activity, Error>) -> Void) {
        completion(.success(Activity.mockedData))
    }
}
