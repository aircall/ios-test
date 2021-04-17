//
//  CallRow.swift
//  AircallUI
//
//  Created by Patricio Guzman on 13/04/2021.
//

import SwiftUI
import Core

struct CallRow: View {

    private let call: Call

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: call.direction == .inbound ? .phoneFillArrowDownLeft : .phoneFillArrowUpRight)
                .resizable()
                .frame(width: 30, height: 30)

            VStack(spacing: 0) {
                Text(call.from)
                Text(call.to ?? "")
            }

            Text("jeudi")

            Image(systemName: .infoCicle)

        }
        .padding(.vertical, 24)
        .padding(.leading, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    init(_ call: Call) {
        self.call = call
    }
}

struct CallRow_Previews: PreviewProvider {
    static var previews: some View {
        CallRow(Call())
    }
}
