//
//  BikeStationListView.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import SwiftUI

struct BikeStationListView: View {
    @ObservedObject var viewModel: BikeStationListViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                navigationBar
                bikeList
            }
            .ignoresSafeArea(edges: .top)
            .alert(item: $viewModel.feedback, content: alertView)
            .hideNavigationBar()
        }
    }
    
    private var navigationBar: some View {
        CustomNavigationBar(isBackButtonEnabled: false)
    }
    
    private var bikeList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.stationsList) { feature in
                    NavigationLink(destination: StationDetailsView(viewModel: StationDetailsViewModel(feature: feature))) {
                        BikeStationCell(feature: feature, userLocation: $viewModel.userLocation)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 0))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                    }
                }
            }
            .padding(.vertical)
        }
        .trackActivity(isLoading: $viewModel.isLoading)
    }
    
    
    private func alertView(feedback: BikeStationListViewModel.FeedbackToUser) -> Alert {
        switch feedback {
        case let .error(localizedDescription):
            return Alert(title: Text(localizedDescription))
        }
    }
}

struct BikeStationListView_Previews: PreviewProvider {
    static var previews: some View {
        BikeStationListView(viewModel: BikeStationListViewModel())
    }
}
