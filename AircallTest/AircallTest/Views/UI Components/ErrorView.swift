//
//  ErrorView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    private let onRetry: (() -> Void)?
    private let error: String
    
    /// Init with error message and function to trigger in order to retry api call
    init(error: String, onRetry: (() -> Void)?) {
        self.error = error
        self.onRetry = onRetry
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
            Text(error)
                .font(.body)
                .multilineTextAlignment(.center)
            
            ActionButton(title: "Retry", image: "arrow.clockwise", onSelect: {
                onRetry?()
            })
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "An error has occured, please retry", onRetry: nil)
        
    }
}

