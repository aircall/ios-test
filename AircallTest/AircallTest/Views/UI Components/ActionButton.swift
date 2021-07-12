//
//  ActionButton.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation
import SwiftUI

struct ActionButton: View {
    private let title: String
    private let image: String
    private let backgroundColor: Color
    private let onSelect: (() -> Void)?
    
    init(title: String, image: String, backgroundColor: Color? = .main, onSelect: (() -> Void)?) {
        self.title = title
        self.image = image
        self.backgroundColor = backgroundColor ?? .main
        self.onSelect = onSelect
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Button(action: {
                onSelect?()
            }) {
                HStack {
                    Image(systemName: image)
                        .font(.headline)
                    Text(title)
                        .fontWeight(.semibold)
                        .font(.headline)
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(backgroundColor)
                .cornerRadius(40)
            }
            Spacer()
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(title: "Archive", image: "archivebox.circle", onSelect: nil)
            .previewLayout(.sizeThatFits)
    }
}
