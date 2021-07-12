//
//  AsyncView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 09/07/2021.
//

import Foundation
import SwiftUI

// View used to load content when view appears
// Allow a better control of differents state, and more flexibility if we need to show data / error / empty state...
struct LoadableView<ViewModel: LoadableViewModelType, Content: View>: View {
    @ObservedObject var viewModel: ViewModel
    private let content: (ViewModel.Output) -> Content
    
    init(viewModel: ViewModel, @ViewBuilder content: @escaping (ViewModel.Output) -> Content) {
        self.viewModel = viewModel
        self.content = content
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear {
                    viewModel.load()
                }
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error.localizedDescription, onRetry: {
                    viewModel.load()
                })
            case .loaded(let output):
                content(output)
            case .empty:
                ErrorView(error: "All calls seems archived, well done !", onRetry: {
                    viewModel.load()
                })
            }
        }
    }
}
