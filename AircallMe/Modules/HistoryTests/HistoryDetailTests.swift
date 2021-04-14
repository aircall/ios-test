//
//  HistoryDetailTests.swift
//  HistoryTests
//
//  Created by Rudy Frémont on 13/04/2021.
//

import XCTest
@testable import History
import CommonUI

class HistoryDetailTests: XCTestCase {
    
    func testHistoryDetailWithCoder() {
        let someView = HistoryDetailVC(coder: NSCoder())
        XCTAssertNil(someView)
    }

    func testHistoryDetail() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryDetailVM(historyModel: MockData.oneItem.fakeModel(), historyService: services)
        
        //Verify VM construction
        XCTAssertTrue(viewModel.sectionsCount() == 2)
        XCTAssertTrue(viewModel.itemsCount(section: 0) == 1)
        XCTAssertTrue(viewModel.itemsCount(section: 1) == 2)
        XCTAssertTrue(viewModel.title == "May 05, 2:30 PM")
        XCTAssertTrue(viewModel.headerForSection(section: 0).string == "Contact Information")
        XCTAssertTrue(viewModel.headerForSection(section: 1).string == "Call Information (1sec)")
        
        let cellVM_0_0 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 0))
        
        //Verify Contact Information
        XCTAssertTrue(cellVM_0_0.displayInfoButton)
        XCTAssertNil(cellVM_0_0.dateLabel)
        XCTAssertTrue(cellVM_0_0.directionTintColor == CommonUI.R.color.accentColor()!)
        XCTAssertTrue(cellVM_0_0.durationLabel == "1sec")
        XCTAssertNil(cellVM_0_0.hourLabel)
        XCTAssertTrue(cellVM_0_0.identifier == 1)
        XCTAssertTrue(cellVM_0_0.mainLabel == "B")
        XCTAssertTrue(cellVM_0_0.secondLabel == "French Republic")
        
        let cellVM_0_1 = viewModel.cellViewModel(at: IndexPath(row: 0, section: 1))
        //Verify Call Information - first row
        XCTAssertFalse(cellVM_0_1.displayInfoButton)
        XCTAssertNil(cellVM_0_1.dateLabel)
        XCTAssertTrue(cellVM_0_1.directionTintColor == .systemRed)
        XCTAssertTrue(cellVM_0_1.durationLabel == "1sec")
        XCTAssertNil(cellVM_0_1.hourLabel)
        XCTAssertTrue(cellVM_0_1.identifier == 1)
        XCTAssertTrue(cellVM_0_1.mainLabel == "Incoming call answered")
        XCTAssertNil(cellVM_0_1.secondLabel)
        
        let cellVM_1_1 = viewModel.cellViewModel(at: IndexPath(row: 1, section: 1))
        //Verify Call Information - second row
        XCTAssertFalse(cellVM_1_1.displayInfoButton)
        XCTAssertNil(cellVM_1_1.dateLabel)
        XCTAssertTrue(cellVM_1_1.directionTintColor == CommonUI.R.color.accentColor()!)
        XCTAssertTrue(cellVM_1_1.durationLabel == "1sec")
        XCTAssertNil(cellVM_1_1.hourLabel)
        XCTAssertTrue(cellVM_1_1.identifier == 1)
        XCTAssertTrue(cellVM_1_1.mainLabel == "C")
        XCTAssertTrue(cellVM_1_1.secondLabel == "A")
    }
    
    func testHistoryDetailWithModelWithoutDate() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryDetailVM(historyModel: MockData.oneItem.fakeModelWithoutDate(), historyService: services)
        
        //Verify VM construction for specific date case
        XCTAssertNil(viewModel.title)
    }
    
    func testArchiveItemSuccess() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryDetailVM(historyModel: MockData.oneItem.fakeModel(archive: false), historyService: services)
        
        viewModel.archiveItem { (result) in
            XCTIsSuccess(result)
        }
    }
    
    func testArchiveItemFailure() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryDetailVM(historyModel: MockData.oneItem.fakeModel(archive: false), historyService: services)
        
        mockAPI.nextStatusCode = .serviceUnavailable
        viewModel.archiveItem { (result) in
            XCTIsFailure(result)
        }
    }
    
    func testArchiveItemFailureWithoutStatusCode() {
        let mockAPI = MockAPIRequest()
        let services = HistoryServicesImpl(manager: mockAPI)
        let viewModel = HistoryDetailVM(historyModel: MockData.oneItem.fakeModel(archive: false), historyService: services)
        
        mockAPI.nextStatusCode = nil
        viewModel.archiveItem { (result) in
            XCTIsFailure(result)
        }
    }

}
