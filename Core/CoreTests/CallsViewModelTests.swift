//
//  CoreTests.swift
//  CoreTests
//
//  Created by Patricio Guzman on 13/04/2021.
//

import Quick
import Nimble
import NetworkingMocks
import Combine
@testable import Core

class CallsViewModelTests: QuickSpec {

    override func spec() {
        var repository: CallRepositoryMock!
        var viewModel: CallsViewModel!
        var disposables: Set<AnyCancellable>!

        beforeEach {
            repository = CallRepositoryMock()
            viewModel = CallsViewModel(callRepository: repository)
            disposables = []
        }

        describe("a CallsViewModel") {
            context("when onAppear is called") {

                context("and calls are fetched") {
                    beforeEach {
                        setupRepository()

                        viewModel.onAppear()
                    }

                    it("should have calls loaded") {
                        expect(viewModel.calls).toEventuallyNot(beEmpty())
                    }
                }

                context("and calls are not fetched") {
                    beforeEach {
                        viewModel.onAppear()
                    }

                    it("should have no calls") {
                        expect(viewModel.calls).toEventually(beEmpty())
                    }
                }
            }

            context("when we archive a call") {
                beforeEach {
                    setupRepository()

                    viewModel.onAppear()

                    waitUntil { done in
                        viewModel.$calls
                            .filter { !$0.isEmpty }
                            .first()
                            .sink { calls in
                                expect(calls).to(haveCount(6))
                                expect(calls[2].id).to(equal(7832))
                                viewModel.onDelete(IndexSet(arrayLiteral: 2))
                                done()
                            }
                            .store(in: &disposables)
                    }
                }

                it("should dissapear") {
                    expect(viewModel.calls).notTo(containElementSatisfying { $0.id == 7832})
                    expect(viewModel.calls).toEventually(haveCount(5))
                }

                context("and then we reset our calls") {
                    beforeEach {
                        viewModel.resetCalls()
                    }

                    it("should have all calls") {
                        expect(viewModel.calls).to(containElementSatisfying { $0.id == 7832})
                        expect(viewModel.calls).toEventually(haveCount(6))
                    }
                }

            }

        }

        func setupRepository() {
            let path = Bundle(for: type(of: self)).path(forResource: "Calls", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let calls = try! JSONDecoder().decode([Call].self, from: data)

            repository.persistedCalls = calls
            repository.calls = calls
        }
    }
}
