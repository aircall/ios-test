//
//  ActivityDetailsView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation
import SwiftUI

// I use view data instead of Activity object because I dont like the fact that the view has to do string parsing / handle nil case etc
// This way I can have a better separation of datas and view, I can be faster to update views if needed
struct ActivityDetailsViewData {
    let status: CallStatusViewData
    let type: String
    let from: String
    let via: String
    let to: String
    let duration: String
    let date: Date
    
    init(activity: Activity) {
        status = CallStatusViewData(activity: activity)
        type = activity.callType == .voicemail ? "Voicemail" : "\(activity.callType.rawValue) call"
        from = "From \(activity.from)"
        via = "Via \(activity.via)"
        to = "To \(activity.to ?? "Unkwown")"
        duration = "\(activity.duration) seconds"
        date = activity.createdAt
    }
}

struct ActivityDetailsView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var showArchiveConfirmation = false
    @ObservedObject private var viewModel: ActivityDetailsViewModel
    private let onReloadList: (() -> Void)?
    
    
    init(viewModel: ActivityDetailsViewModel, onReloadList: (() -> Void)?) {
        self.viewModel = viewModel
        self.onReloadList = onReloadList
    }
    
    var body: some View {
        ZStack {
            VStack {
                LoadableView(viewModel: viewModel) { activity in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Spacer()
                            CallStatusView(viewData: activity.status)
                                .font(.largeTitle)
                                .padding()
                                .overlay(
                                    Circle().stroke(Color.main, lineWidth: 2)
                                )
                            Spacer()
                        }
                        HStack(alignment: .center) {
                            Spacer()
                            Text("\(activity.type)".uppercased())
                                .font(.title)
                                .accessibility(identifier: "typeText")
                            Spacer()
                            
                        }
                        dateRow(activity: activity)
                        callRow(activity: activity)
                        ActionButton(title: "Archive", image: "archivebox.fill", onSelect: {
                            showArchiveConfirmation.toggle()
                        })
                        .accessibility(identifier: "archiveButton")
                    }
                    .padding()
                    .font(.body)
                    Spacer()
                }
            }
            ConfirmArchiveView(isPresented: $showArchiveConfirmation, id: .constant(viewModel.id), viewModel: .init(apiManager: viewModel.apiManager), onFinish: {
                presentationMode.wrappedValue.dismiss()
                onReloadList?()
            })
        }
    }
    
    private func dateRow(activity: ActivityDetailsViewData) -> some View {
        return VStack(alignment: .leading) {
            Divider()
            Text(activity.date, style: .date)
                .accessibility(identifier: "dateText")
            Text(activity.date, style: .time)
                .accessibility(identifier: "timeText")
            Text(activity.duration)
                .foregroundColor(.gray)
        }
    }
    
    private func callRow(activity: ActivityDetailsViewData) -> some View {
        return VStack(alignment: .leading) {
            Divider()
            Text(activity.from)
                .accessibility(identifier: "fromText")
            Text(activity.to)
                .accessibility(identifier: "toText")
            Text(activity.via)
                .accessibility(identifier: "viaText")
            Divider()
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ActivityDetailsViewModel(apiManager: MockApiManager(), id: 0)
        ActivityDetailsView(viewModel: viewModel, onReloadList: nil)
    }
}
