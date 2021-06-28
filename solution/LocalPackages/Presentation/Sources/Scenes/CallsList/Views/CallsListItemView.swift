//
//  CallsListItemView.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Domain
import SwiftUI

struct CallsListItemView: View {

    private let viewModel: CallsListItemViewModel

    var body: some View {
        HStack {
            Image.icon(for: viewModel.callDirection)
                .foregroundColor(viewModel.status == .success ? .green : .red)
            VStack(alignment: .leading) {
                Text(viewModel.caller)
                    .font(.callout)
                    .foregroundColor(.primary)
                Text(viewModel.formattedInfo)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            .padding()
            .layoutPriority(1)
            Spacer()
            VStack(alignment: .trailing) {
                Text(viewModel.formattedDate)
                    .font(.callout)
                    .foregroundColor(.secondary)
                Text(viewModel.formattedTime)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            .layoutPriority(2)
            Image.callInfo
                .foregroundColor(.gray)
                .padding(.leading, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: Constants.defaultRowHeight, alignment: .leading)
    }

    init(_ viewModel: CallsListItemViewModel) {
        self.viewModel = viewModel
    }
}

#if DEBUG
struct CallsListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CallsListItemView(CallsListItemViewModel(MockedDomain.calls[0]))
            .preferredColorScheme(.light)
            .environment(\.sizeCategory, .medium)
    }
}
#endif
