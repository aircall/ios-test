//
//  ActivitiesView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import SwiftUI

struct ActivitiesView : View {
    @State private var showArchiveConfirmation = false
    @State private var selectedCallId: Int = 0
    @ObservedObject private var viewModel: ActivitiesViewModel
    
    init(viewModel: ActivitiesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    LoadableView(viewModel: viewModel) { activities in
                        List(activities) { activity in
                            NavigationLink(destination: ActivityDetailsView(viewModel: .init(apiManager: viewModel.apiManager, id: activity.id), onReloadList: {
                                viewModel.load()
                            })) {
                                ActivityRow(activity: activity, onArchive: {
                                    // if archive button is selected, select call id and show archive confirmation alert
                                    selectedCallId = activity.id
                                    showArchiveConfirmation.toggle()
                                })
                            }
                        }
                        .accessibility(identifier: "activitiesList")
                    }
                }
                ConfirmArchiveView(isPresented: $showArchiveConfirmation, id: $selectedCallId, viewModel: .init(apiManager: viewModel.apiManager), onFinish: {
                    showArchiveConfirmation = false
                    viewModel.load()
                })
            }
            .navigationTitle("History")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ActivtiesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ActivitiesViewModel(apiManager: MockApiManager())
        ActivitiesView(viewModel: viewModel)
    }
}
