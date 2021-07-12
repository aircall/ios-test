//
//  CallStatus.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 06/07/2021.
//

import Foundation
import SwiftUI


struct CallStatusViewData {
    let imageName: String
    let color: Color
    
    init(activity: Activity) {
        imageName = activity.direction == .inbound ?
            "phone.arrow.up.right" :
            "phone.arrow.down.left"
        
        switch activity.callType {
        case .missed:
           color = .red
        case .voicemail:
            color = .orange
        case .answered:
            color = .green
        }
    }
}

struct CallStatusView: View {
    var viewData: CallStatusViewData
    
    var body: some View {
        Image(systemName: viewData.imageName)
            .foregroundColor(viewData.color)
            .accessibility(identifier: "callStatusView")
    }
}

struct CallStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Activities.mockedData) { activity in
            let viewData = CallStatusViewData(activity: activity)
            CallStatusView(viewData: viewData)
                .previewLayout(.sizeThatFits)
                .font(.title)
        }
    }
}
