//
//  CallsView.swift
//  AircallUI
//
//  Created by Patricio Guzman on 12/04/2021.
//

import SwiftUI
import Core
//remove this
import Networking

public struct CallsView: View {

    @ObservedObject private var viewModel: CallsViewModel

    public var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.calls) { call in
//                    ZStack {
                        CallRow(call)
                        NavigationLink(destination: destination(for: call)) { EmptyView() }
                            .opacity(0)
//                    }
                }
                .onDelete(perform: viewModel.onDelete)
            }
            .navigationBarTitle(Text("History"))
            .navigationBarItems(trailing: Button("Reset") {
                viewModel.resetCalls()
            })
        }
        .onAppear(perform: viewModel.onAppear)
    }

    public init(viewModel: CallsViewModel) {
        self.viewModel = viewModel
    }

    private func destination(for call: Call) -> some View {
        CallDetail(call)
    }
}

struct CallsView_Previews: PreviewProvider {
    static var previews: some View {
        CallsView(viewModel: CallsViewModel(session: SessionForPreview()))
    }
}
