//
//  ConfirmArchiveVIew.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 10/07/2021.
//

import Foundation
import SwiftUI

struct ConfirmArchiveView: View {
    private let onFinish: (() -> Void)?
    @Binding private var isPresented: Bool
    @Binding private var id: Int
    @ObservedObject private var viewModel: ArchiveViewModel
    
    init(isPresented: Binding<Bool>, id: Binding<Int>, viewModel: ArchiveViewModel, onFinish: (() -> Void)?) {
        self._isPresented = isPresented
        self._id = id
        self.viewModel = viewModel
        self.onFinish = onFinish
        
    }
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                VStack(alignment: .center, spacing: 16) {
                    Text("Archive call")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.main)
                        .foregroundColor(Color.white)
                        .accessibility(identifier: "archiveTitleText")
                    Text(viewModel.error ?? "Do you really want to archive this call ?")
                        .foregroundColor(viewModel.error != nil ? .red : .black)
                        .padding()
                        .multilineTextAlignment(.center)
                        .accessibility(identifier: "bodyText")
                    Spacer()
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    ActionButton(title: "Archive", image: "checkmark.circle.fill", backgroundColor: .green, onSelect: {
                        viewModel.archiveCall(id: id)
                    })
                    .accessibility(identifier: "confirmButton")
                    
                    ActionButton(title: "Cancel", image: "xmark.circle.fill", backgroundColor: .red, onSelect: {
                        self.isPresented = false
                    })
                    .padding(.bottom, 16)
                    .accessibility(identifier: "cancelButton")
                }
                .frame(width: 300, height: 350)
                .background(Color.white)
                .cornerRadius(20).shadow(radius: 20)
            }
            .onChange(of: viewModel.isArchived) { isDone in
                if isDone {
                    onFinish?()
                    viewModel.isArchived = false
                }
            }
        }
    }
}

struct ConfirmArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmArchiveView(isPresented: .constant(true), id: .constant(0), viewModel: ArchiveViewModel(apiManager: MockApiManager()), onFinish: nil)
    }
}

