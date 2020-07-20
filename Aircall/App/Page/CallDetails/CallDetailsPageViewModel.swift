//
//  CallPageDetailsViewModel.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine

class CallDetailsPageViewModel {
    let call: Call
    private let archived: () -> Void
    private let callRepository: CallRepository
    private var bag: Set<AnyCancellable> = []
    
    init(call: Call, callRepository: CallRepository = CallRepositoryAdapter(), onArchived: @escaping () -> Void) {
        self.call = call
        self.archived = onArchived
        self.callRepository = callRepository
    }
    
    @objc
    func archiveAction() {
        callRepository
            .archive(call: call)
            .sink(receiveCompletion: { _ in }) { [weak self] _ in self?.archived() }
            .store(in: &bag)
    }
}
