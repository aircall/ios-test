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
        let calls: [Call]
    }
    
    @Published private(set) var state: State
    
    init(state: State) {
        self._state = Published(initialValue: state)
    }
}
