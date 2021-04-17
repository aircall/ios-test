//
//  CallDetail.swift
//  AircallUI
//
//  Created by Patricio Guzman on 15/04/2021.
//

import SwiftUI
import Core

struct CallDetail: View {

    private let call: Call

    init(_ call: Call) {
        self.call = call
    }

    var body: some View {
        Text("Hello, World!")
            .navigationBarItems(trailing: Button(action: {}, label: {
                Image(systemName: .archiveboxFill)
            }))
    }
}

struct CallDetail_Previews: PreviewProvider {
    static var previews: some View {
        CallDetail(Call())
    }
}
