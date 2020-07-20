//
//  ActivityFeedPageViewModel.swift
//  Aircall
//
//  Created by JC on 09/07/2020.
//  Copyright © 2020 JC. All rights reserved.
//

import Foundation
import Combine

class ActivityFeedPageViewModel {
    struct State {
        var calls: [Call]
        var selectedCall: Call?
    }
    
    @Published private(set) var state: State
    private let callRepository: CallRepository
    private var bag: Set<AnyCancellable> = []
    
    init(state: State, callRepository: CallRepository) {
        self._state = Published(initialValue: state)
        self.callRepository = callRepository
    }
    
    func load() {
        callRepository
            .loadAll()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] in self?.state.calls = $0 })
            .store(in: &bag)
    }
    
    func selectAction(call: Call?) {
        state.selectedCall = call
    }
}
