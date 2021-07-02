//
//  NetworkingTests.swift
//  NetworkingAircallTests
//
//  Created by Delphine Garcia on 25/06/2021.
//

import XCTest
@testable import NetworkingAircall

class ServerServiceStub: ServerService {
    
    enum StubError: Error {
        case stubNotFound
    }
    
    func performRequest(_ request: URLRequestable, completion: @escaping (Result<Data, Error>) -> Void) {
        let fileName: String
        switch request {
        case EndPoint.getActivities:
            fileName = "Activities"
        default:
            fileName = ""
        }
        
        if let path = Bundle(for: DataProviderDecoderTests.self).path(forResource: fileName, ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) {
            completion(.success(jsonData))
        } else {
            completion(.failure(StubError.stubNotFound))
        }
    }
}

class DataProviderDecoderTests: XCTestCase {

    func testEndPoint() throws {
        XCTAssertEqual(EndPoint.getActivities.asURLRequest().url?.absoluteString, "https://aircall-job.herokuapp.com/activities")
        XCTAssertEqual(EndPoint.archiveActivity(id: 0).asURLRequest().url?.absoluteString, "https://aircall-job.herokuapp.com/activities/0")
        XCTAssertEqual(EndPoint.reset.asURLRequest().url?.absoluteString, "https://aircall-job.herokuapp.com/reset")
    }
    
    func testDecoderActivities() throws {
        //Given
        let stub = ServerServiceStub()
        let sut = JSONDecoder()
        
        let expectation = self.expectation(description: "Fake network should return data")
        var networkfakeResult: Result<Data, Error>?
        stub.performRequest(EndPoint.getActivities) { (result) in
            networkfakeResult = result
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        let networkResult = try XCTUnwrap(networkfakeResult)
        
        //When
        let decodedDataResult: Result<[ActivityNWK], Error> = sut.decode(data: networkResult)
        
        //Then
        switch decodedDataResult {
        case .success(let activities):
            XCTAssertNotEqual(activities.count, 0)
            XCTAssertEqual(activities.first?.id, 7834)
        case .failure(_):
            XCTFail("Decoding should not fail")
        }
    }
    
    func testDataProvider_loadActivities() throws {
        //Given
        let sut = DataProvider(service: ServerServiceStub())
        
        let expectation = self.expectation(description: "Stub data should have been decoded and returned")
        var activitiesResult: Result<[ActivityNWK], Error>?
        
        //When
        sut.loadActivities { result in
            activitiesResult = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then
        let decodedDataResult = try XCTUnwrap(activitiesResult)
        switch decodedDataResult {
        case .success(let activities):
            XCTAssertNotEqual(activities.count, 0)
            XCTAssertEqual(activities.first?.id, 7834)
        case .failure(let error):
            XCTFail("Decoding should not fail \(error)")
        }
    }
    
    func testDataProvider_archive() throws {
        //Given
        let sut = DataProvider(service: ServerServiceStub())
        
        let expectation = self.expectation(description: "Stub data should have been decoded and returned")
        var result: Error?
        
        //When
        sut.archiveActivity(id: 7834) { error in
            result = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then
        XCTAssertTrue(result == nil)
    }
    
    func testDataProvider_resetData() throws {
        //Given
        let sut = DataProvider(service: ServerServiceStub())
        
        let expectation = self.expectation(description: "Stub data should have been decoded and returned")
        var result: Error?
        
        //When
        sut.reset { error in
            result = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then
        XCTAssertTrue(result == nil)
    }
}
