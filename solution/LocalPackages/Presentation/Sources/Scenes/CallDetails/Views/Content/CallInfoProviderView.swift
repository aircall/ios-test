//
//  CallInfoProviderView.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import SwiftUI

struct CallInfoProviderView: View {

    private let viewModel: CallInfoProviderViewModel

    var body: some View {
        HStack {
            Image(uiImage: viewModel.flagIcon.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.defaultFlagSize)
            VStack(alignment: .leading) {
                Text(viewModel.provider)
                    .font(.callout)
                    .foregroundColor(.primary)
                Text(viewModel.number)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .padding(.horizontal, Constants.defaultRowHorizontalPadding)
        .frame(maxWidth: .infinity, maxHeight: Constants.defaultRowHeight, alignment: .leading)
    }

    init(_ viewModel: CallInfoProviderViewModel) {
        self.viewModel = viewModel
    }
}

#if DEBUG
struct CallInfoProviderView_Previews: PreviewProvider {
    static var previews: some View {
        CallInfoProviderView(CallInfoProviderViewModel(MockedDomain.calls[0]))
            .preferredColorScheme(.light)
            .environment(\.sizeCategory, .medium)
    }
}
#endif
