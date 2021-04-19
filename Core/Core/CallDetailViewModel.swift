//
//  CallDetailViewModel.swift
//  Core
//
//  Created by Patricio Guzman on 18/04/2021.
//

import Combine

public class CallDetailViewModel {

    private let callRepository: CallRepositoryType
    private var disposables: Set<AnyCancellable> = []

    var call: Call

    public init(call: Call, callRepository: CallRepositoryType) {
        self.call = call
        self.callRepository = callRepository
    }

    public func archiveCall() {
        let id = String(call.id)
        callRepository.archiveCall(with: id)
            .sink { _ in
            } receiveValue: { [weak self] _ in
                self?.call.archive()
            }
            .store(in: &disposables)
    }
}
