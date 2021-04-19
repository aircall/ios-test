//
//  CallDetail.swift
//  AircallUI
//
//  Created by Patricio Guzman on 15/04/2021.
//

import SwiftUI
import Core

struct CallDetail: View {

    private let viewModel: CallDetailViewModel

    init(viewModel: CallDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text("Hello, World!")
            .navigationBarItems(trailing: archiveButton)
    }

    private var archiveButton: some View {
        Button(action: viewModel.archiveCall, label: {
            Image(systemName: .archiveboxFill)
        })
    }
}
