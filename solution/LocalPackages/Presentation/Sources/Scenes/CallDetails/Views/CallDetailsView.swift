//
//  CallDetailsView.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Foundation
import Domain
import SwiftUI

public struct CallDetailsView: View {

    @ObservedObject
    private var viewModel: CallDetailsViewModel

    public var body: some View {
        content
            .navigationBarTitle(viewModel.title)
    }

    private var content: AnyView {
        switch viewModel.details {
        case .notRequested: return AnyView(notRequestedView)
        case .isLoading: return AnyView(loadingView)
        case let .loaded(details): return AnyView(loadedView(details))
        case let .failed(error): return AnyView(failedView(error))
        }
    }

    init(_ viewModel: CallDetailsViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Loading Content

private extension CallDetailsView {
    var notRequestedView: some View {
        EmptyView()
    }

    var loadingView: some View {
        Text(L10n.loadingIndicatorTitle).padding()
    }

    func loadedView(_ details: (archived: Bool, sections: [CallDetailsSectionViewModel])) -> some View {
        List {
            ForEach(details.sections) { section in
                Section(header: header(with: section),
                        footer: footer(with: section)) {
                    ForEach(section.items) { item in
                        row(with: item)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(viewModel.title)
        .navigationBarItems(trailing: archiveButton(archived: details.archived))
    }

    func failedView(_ error: Error) -> some View {
        Text(error.localizedDescription).padding()
    }
}

private extension CallDetailsView {
    func header(with viewModel: CallDetailsSectionViewModel) -> some View {
        CallDetailsHeaderView(viewModel.title, details: viewModel.details)
    }

    func footer(with viewModel: CallDetailsSectionViewModel) -> some View {
        switch viewModel.footerType {
        case .none: return AnyView(EmptyView())
        case .actions: return AnyView(CallDetailsFooterView(self.viewModel))
        }
    }

    func row(with viewModel: CallDetailsItemViewModel) -> some View {
        switch viewModel {
        case let contactInfo as ContactInfoViewModel:
            return AnyView(ContactInfoView(contactInfo))
        case let callInfoStats as CallInfoStatsViewModel:
            return AnyView(CallInfoStatsView(callInfoStats))
        case let callInfoProvider as CallInfoProviderViewModel:
            return AnyView(CallInfoProviderView(callInfoProvider))
        default:
            return AnyView(EmptyView())
        }
    }

    func archiveButton(archived: Bool) -> some View {
        Button(action: { viewModel.archiveCall(!archived) }, label: {
            Image.icon(for: archived ? .unarchive : .archive,
                       sized: Constants.defaultBarButtonIconSize)
        })
    }
}

#if DEBUG
struct CallDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CallDetailsView(CallDetailsViewModel.mock)
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .medium)
    }
}
#endif
