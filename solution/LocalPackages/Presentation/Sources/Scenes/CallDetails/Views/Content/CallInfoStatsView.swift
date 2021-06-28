//
//  CallInfoStatsView.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import SwiftUI

struct CallInfoStatsView: View {

    private let viewModel: CallInfoStatsViewModel

    var body: some View {
        HStack {
            Image.icon(for: viewModel.callDirection)
                .foregroundColor(viewModel.status == .success ? .green : .red)
            VStack(alignment: .leading) {
                Text(viewModel.detailedDescription)
                    .font(.callout)
                    .foregroundColor(.primary)
                Text(viewModel.detailedStatus)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .padding(.horizontal, Constants.defaultRowHorizontalPadding)
        .frame(maxWidth: .infinity, maxHeight: Constants.defaultRowHeight, alignment: .leading)
    }

    init(_ viewModel: CallInfoStatsViewModel) {
        self.viewModel = viewModel
    }
}

#if DEBUG
struct CallInfoStatsView_Previews: PreviewProvider {
    static var previews: some View {
        CallInfoStatsView(CallInfoStatsViewModel(MockedDomain.calls[0]))
            .preferredColorScheme(.light)
            .environment(\.sizeCategory, .medium)
    }
}
#endif
