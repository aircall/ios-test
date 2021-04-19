//
//  CallDetailViewModelTests.swift
//  CoreTests
//
//  Created by Patricio Guzman on 19/04/2021.
//

import Quick
import Nimble
import Combine
@testable import Core

class CallDetailViewModelTests: QuickSpec {

    override func spec() {
        var repository: CallRepositoryMock!
        var viewModel: CallDetailViewModel!

        beforeEach {
            repository = CallRepositoryMock()
            viewModel = CallDetailViewModel(call: Call(), callRepository: repository)
        }

        describe("a CallDetailViewModel") {
            context("when we archive a call") {
                beforeEach {
                    viewModel.archiveCall()
                }

                it("should archive the call") {
                    expect(viewModel.call.isArchived).to(beTrue())
                }

            }
            
            
        }
        
    }
}
