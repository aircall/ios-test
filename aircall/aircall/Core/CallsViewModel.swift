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

    private let callRepository: CallRepositoryType
    private var disposables: Set<AnyCancellable> = []

    public init(callRepository: CallRepositoryType) {
        self.callRepository = callRepository
    }

    public func onAppear() {
        callRepository.fetchAll()
            .sink { error in
                return
            } receiveValue: { [weak self] calls in
                self?.calls = calls.filter { $0.isArchived == false }
            }
            .store(in: &disposables)
    }

    public func buildCallDetailViewModel(for call: Call) -> CallDetailViewModel {
        CallDetailViewModel(call: call, callRepository: callRepository)
    }

    public func onDelete(_ indexSet: IndexSet) {
        for index in indexSet {
            let id = String(calls[index].id)
            callRepository.archiveCall(with: id)
                .replaceError(with: ())
                .sink { _ in }
                .store(in: &disposables)
        }
        indexSet.forEach { calls.remove(at: $0) }
    }

    public func resetCalls() {
        callRepository.resetAll()
            .flatMap { [weak self] in
                self?.callRepository.fetchAll() ?? CurrentValueSubject([]).eraseToAnyPublisher()
            }
            .sink { _ in
            } receiveValue: { [weak self] (calls: [Call]) in
                self?.calls = calls
            }
            .store(in: &disposables)
    }
}
