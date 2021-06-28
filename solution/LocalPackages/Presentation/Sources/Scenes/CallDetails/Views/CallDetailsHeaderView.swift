//
//  CallDetailsHeaderView.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import SwiftUI

struct CallDetailsHeaderView: View {

    private let title: String
    private let details: String?

    var body: some View {
        content
    }

    private var content: some View {
        HStack {
            Text(title)
                .font(.headline)
            details.map {
                Text($0)
                    .font(.subheadline)
            }
        }
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, maxHeight: Constants.defaultHeaderHeight, alignment: .leading)
    }

    init(_ title: String, details: String? = nil) {
        self.title = title
        self.details = details
    }
}

#if DEBUG
struct CallDetailsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let title = L10n.callInformationTitle
        let details: String? = "(5sec)"
        return CallDetailsHeaderView(title, details: details)
            .preferredColorScheme(.light)
            .environment(\.sizeCategory, .medium)
    }
}
#endif
