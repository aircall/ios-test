//
//  CallsListView.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import SwiftUI

public struct CallsListView: View {

    @ObservedObject
    private var viewModel: CallsListViewModel

    public var body: some View {
        content
            .navigationBarTitle(viewModel.title)
            .onAppear(perform: viewModel.update)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                viewModel.update()
            }
    }

    private var content: AnyView {
        switch viewModel.calls {
        case .notRequested: return AnyView(notRequestedView)
        case .isLoading: return AnyView(loadingView)
        case let .loaded(calls): return AnyView(loadedView(calls))
        case let .failed(error): return AnyView(failedView(error))
        }
    }

    init(_ viewModel: CallsListViewModel) {
        self.viewModel = viewModel
    }
}

private extension CallsListView {
    var notRequestedView: some View {
        EmptyView()
    }

    var loadingView: some View {
        Text(L10n.loadingIndicatorTitle).padding()
    }

    func loadedView(_ calls: [CallsListItemViewModel]) -> some View {
        List(calls) { call in
            Button(action: { viewModel.didSelect(call) }, label: {
                CallsListItemView(call)
            })
        }
        .listStyle(GroupedListStyle())
    }

    func failedView(_ error: Error) -> some View {
        Text(error.localizedDescription).padding()
    }
}

#if DEBUG
struct CallsListView_Previews: PreviewProvider {
    static var previews: some View {
        CallsListView(CallsListViewModel.mock)
    }
}
#endif
