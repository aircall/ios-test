//
//  ContactInfoView.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import SwiftUI

struct ContactInfoView: View {

    private let viewModel: ContactInfoViewModel

    var body: some View {
        HStack {
            photoIcon
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.defaultAvatarSize)
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.callout)
                    .foregroundColor(.primary)
                viewModel.location.map {
                    Text($0)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .layoutPriority(1)
            Spacer()
            Image.callInfo
                .foregroundColor(.gray)
                .padding(.leading, 5)
        }
        .padding(.horizontal, Constants.defaultRowHorizontalPadding)
        .frame(maxWidth: .infinity, maxHeight: Constants.defaultRowHeight, alignment: .leading)
    }

    init(_ viewModel: ContactInfoViewModel) {
        self.viewModel = viewModel
    }

    private var photoIcon: some View {
        guard let photoData = viewModel.photo,
              let uiImage = UIImage(data: photoData) else {
            return AnyView(Image.unkownContact)
        }
        return AnyView(Image(uiImage: uiImage))
    }
}

#if DEBUG
struct ContactInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactInfoView(ContactInfoViewModel(MockedDomain.calls[0]))
    }
}
#endif
