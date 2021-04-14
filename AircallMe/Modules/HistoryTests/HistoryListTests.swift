//
//  HistoryListTests.swift
//  HistoryTests
//
//  Created by Rudy Frémont on 13/04/2021.
//

import XCTest
@testable import History
import Networking

class HistoryListTests: XCTestCase {

    func testHistoryListWithCoder() {
        let someView = HistoryListVC(coder: NSCoder())
        XCTAssertNil(someView)
    }
    
    func testGetHistoryListSuccess() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryListVM(historyService: services)
        
        mockAPI.nextData = MockData.tenItem.data

        viewModel.getHistoryList { (result) in
            
            XCTIsSuccess(result)
            XCTAssertTrue(viewModel.itemsCount() == 10)
            
            let cellVM = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
            XCTAssertTrue(cellVM.displayInfoButton == true)
            XCTAssertTrue(cellVM.dateLabel == "May 05")
            XCTAssertTrue(cellVM.directionTintColor == UIColor.systemRed)
            XCTAssertTrue(cellVM.durationLabel == "1sec")
            XCTAssertTrue(cellVM.hourLabel == "2:30 PM")
            XCTAssertTrue(cellVM.identifier == 1)
            XCTAssertTrue(cellVM.mainLabel == "A")
            XCTAssertTrue(cellVM.secondLabel == "on B")
        }
        
        mockAPI.nextData = MockData.tenItemArchived.data
        viewModel.getHistoryList { (result) in
            
            XCTIsSuccess(result)
            XCTAssertTrue(viewModel.itemsCount() == 0)
        }
    }
    
    func testGetHistoryListFailure() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryListVM(historyService: services)
        
        //If no statusCode with request VM has error serviceUnavailable
        mockAPI.nextStatusCode = nil
        viewModel.getHistoryList { (result) in
            
            if case .failure(let code) = result {
                XCTAssertTrue(code == .serviceUnavailable)
            } else {
                XCTFail("Test has to fail")
            }
        }
        
        //If statusCode exists but there is no data then VM has error statusCode
        mockAPI.nextStatusCode = .internalServerError
        mockAPI.nextData = nil

        viewModel.getHistoryList { (result) in
            
            if case .failure(let code) = result {
                XCTAssertTrue(code == .internalServerError)
            } else {
                XCTFail("Test has to fail")
            }
        }

        //If statusCode exists and data exists then if statuscode is not on the success range the VM has internalServerError
        mockAPI.nextStatusCode = .internalServerError
        mockAPI.nextData = MockData.tenItem.data

        viewModel.getHistoryList { (result) in
            
            if case .failure(let code) = result {
                XCTAssertTrue(code == .internalServerError)
            } else {
                XCTFail("Test has to fail")
            }
        }
        
        //If statusCode is success data exists then VM return serviceUnavailable when data cannot be decode
        mockAPI.nextStatusCode = .ok
        mockAPI.nextData = try? ["data": "fake"].encode()

        viewModel.getHistoryList { (result) in

            if case .failure(let code) = result {
                XCTAssertTrue(code == .serviceUnavailable)
            } else {
                XCTFail("Test has to fail")
            }
        }
    }
    
    func testResetArchiveSuccess() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryListVM(historyService: services)
        
        //resetArchiveStatus do a getlist on success
        mockAPI.nextData = MockData.tenItem.data
        viewModel.resetArchiveStatus { (result) in
            XCTIsSuccess(result)
        }
    }
    
    func testResetArchiveFailure() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryListVM(historyService: services)
        
        mockAPI.nextStatusCode = .internalServerError
        viewModel.resetArchiveStatus { (result) in
            XCTIsFailure(result)
        }
    }
    
    func testArchiveItemSuccess() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryListVM(historyService: services)
        
        mockAPI.nextData = MockData.tenItem.data
        
        viewModel.getHistoryList { result in
            
            XCTIsSuccess(result)
            viewModel.archiveItem(at: IndexPath(row: 0, section: 0)) { result in
                XCTIsSuccess(result)
            }
        }
    }
    
    func testArchiveItemFailure() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryListVM(historyService: services)
        
        mockAPI.nextData = MockData.tenItem.data

        viewModel.getHistoryList { (result) in
            
            XCTIsSuccess(result)
            mockAPI.nextStatusCode = .internalServerError
            viewModel.archiveItem(at: IndexPath(row: 0, section: 0)) { (result) in
                XCTIsFailure(result)
            }
        }
    }
    
    func testGetHistoryListSuccessWithBO() {
        let resolver = MockDependencyProvider()
        //Get real APIRequest do no a WS call
        let services = HistoryServicesImpl(manager: resolver.resolver.resolve(APIRequest.self)!)
        let viewModel = HistoryListVM(historyService: services)

        // Create an expectation
        let expectation = self.expectation(description: "getList")

        viewModel.getHistoryList { (result) in
            
            XCTIsSuccess(result)
            XCTAssertTrue(viewModel.itemsCount() == 6)
            // it's OK to proceed else process will timeout
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fullfilled, or time out
        // after 5 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 5, handler: nil)
    }

}
