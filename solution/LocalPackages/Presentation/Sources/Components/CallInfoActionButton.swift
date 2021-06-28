//
//  CallInfoActionButton.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Foundation
import Domain
import SwiftUI

public struct CallInfoActionButton: View {

    @Environment(\.colorScheme) var colorScheme

    private let symbol: SFSymbol
    private let title: String
    private let action: () -> Void

    public var body: some View {
        Button(action: action, label: {
            VStack {
                Image.icon(for: symbol)
                    .padding([.top, .horizontal], 10)
                Text(title)
            }
        })
        .buttonStyle(CallDetailsActionButtonStyle(colorScheme: colorScheme))
        .fixedSize()
    }

    init(symbol: SFSymbol, title: String, action: @escaping () -> Void) {
        self.symbol = symbol
        self.title = title
        self.action = action
    }
}

struct CallDetailsActionButtonStyle: ButtonStyle {
    private let colorScheme: ColorScheme

    init(colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        let backgroundColor: Color = colorScheme == .dark ? .black : .white
        return configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.primary)
            .background(backgroundColor.opacity(configuration.isPressed ? 0.5 : 1))
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .shadow(color: .secondary.opacity(0.5), radius: 10)
    }
}

#if DEBUG
struct CallInfoActionButton_Previews: PreviewProvider {
    static var previews: some View {
        CallInfoActionButton(symbol: .notes, title: "Notes", action: {})
            .preferredColorScheme(.light)
            .environment(\.sizeCategory, .medium)
    }
}
#endif
