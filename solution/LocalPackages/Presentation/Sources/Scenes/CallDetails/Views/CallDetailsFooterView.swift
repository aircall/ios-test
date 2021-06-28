//
//  CallDetailsFooterView.swift
//  
//
//  Created by Jobert on 26/06/2021.
//

import Common
import SwiftUI

public struct CallDetailsFooterView: View {

    private let viewModel: CallDetailsViewModel
    @State private var showingClipboardAlert = false

    public var body: some View {
        VStack {
            HStack {
                CallInfoActionButton(symbol: .notes, title: L10n.notes, action: {})
                CallInfoActionButton(symbol: .tags, title: L10n.tags, action: {})
                CallInfoActionButton(symbol: .assignPerson, title: L10n.assign, action: {})
            }
            .padding()
            Button(L10n.copyCallId) {
                UIPasteboard.general.string = String(viewModel.callId)
                showingClipboardAlert.toggle()
            }
            .foregroundColor(.green)
        }
        .padding(.horizontal, Constants.defaultRowHorizontalPadding)
        .frame(maxWidth: .infinity, maxHeight: Constants.maxFooterHeight, alignment: .center)
        .alert(isPresented: $showingClipboardAlert) {
            Alert(title: Text(L10n.callIdCopied),
                  dismissButton: .default(Text(L10n.ok)))
        }
    }

    init(_ viewModel: CallDetailsViewModel) {
        self.viewModel = viewModel
    }
}

#if DEBUG
struct CallDetailsFooterView_Previews: PreviewProvider {
    static var previews: some View {
        CallDetailsFooterView(CallDetailsViewModel.mock)
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .medium)
    }
}
#endif
