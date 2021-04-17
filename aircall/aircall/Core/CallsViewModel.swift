//
//  CallsViewModel.swift
//  aircall
//
//  Created by Patricio Guzman on 12/04/2021.
//

import Foundation
import Networking
import Combine

public class CallsViewModel: ObservableObject {

    @Published public private(set) var calls: [Call] = []

    private let session: SessionType
    private var disposables: Set<AnyCancellable> = []

    public init(session: SessionType) {
        self.session = session
    }

    public func onAppear() {
        session.dataTaskPublisher(for: .calls)
            .sink { error in
                return
            } receiveValue: { [weak self] calls in
                self?.calls = calls
            }
            .store(in: &disposables)
    }

    public func onDelete(_ indexSet: IndexSet) {
        for index in indexSet {
            session.dataTaskPublisher(for: .updateCall(id: String(calls[index].id)))
                .replaceError(with: ())
                .sink { _ in }
                .store(in: &disposables)
        }
        indexSet.forEach { calls.remove(at: $0) }
    }

    public func resetCalls() {
        session.dataTaskPublisher(for: .reset)
            .flatMap { [weak self] in
                self?.session.dataTaskPublisher(for: .calls) ?? CurrentValueSubject([]).eraseToAnyPublisher()
            }
            .sink { _ in
            } receiveValue: { [weak self] (calls: [Call]) in
                self?.calls = calls
            }
            .store(in: &disposables)
    }
}
