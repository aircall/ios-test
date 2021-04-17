//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Patricio Guzman on 12/04/2021.
//

import Nimble
import Quick
import NetworkingMocks
import Combine
import Core
@testable import Networking

class NetworkingTests: QuickSpec {

    override func spec() {
        var session: SessionMock!
        var disposables: Set<AnyCancellable>!

        describe("a session") {

            beforeEach {
                session = SessionMock()
                disposables = []
            }

            context("when making a call") {

                context("and no data is returned") {

                    it("should fail") {
                        waitUntil { done in
                            session.dataTaskPublisher(for: .calls)
                                .sink { result in
                                    switch result {
                                    case let .failure(error):
                                        expect(error.localizedDescription).to(equal("The data couldn’t be read because it isn’t in the correct format."))
                                        done()
                                    case .finished:
                                        fail("Should have been a failure")
                                    }
                                } receiveValue: { (calls: [Call]) in
                                    fail("This call should have failed")
                                }
                                .store(in: &disposables)
                        }
                    }
                }

                context("and data is returned") {

                    beforeEach {
                        session.responsePathForRequest = { request in
                            switch request {
                            case .calls:
                                return Bundle(for: type(of: self)).path(forResource: "Calls", ofType: "json")!
                            default:
                                fail("this request should not be called")
                                return ""
                            }
                        }
                    }

                    it("should not fail") {
                        waitUntil { done in
                            session.dataTaskPublisher(for: .calls)
                                .sink { result in
                                    switch result {
                                    case .failure:
                                        fail("Should not fail")
                                    case .finished:
                                        done()
                                    }
                                } receiveValue: { (calls: [Call]) in
                                    expect(calls).to(haveCount(6))
                                }
                                .store(in: &disposables)
                        }
                    }
                }
            }
        }
    }
}
