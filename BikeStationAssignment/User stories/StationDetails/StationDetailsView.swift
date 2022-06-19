//
//  StationDetailsView.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import SwiftUI
import MapKit

struct StationDetailsView: View {
    @ObservedObject var viewModel: StationDetailsViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            mapView
            Spacer()
            detailsCell
        }
        .ignoresSafeArea(edges: .top)
        .hideNavigationBar()
    }
    
    private var navigationBar: some View {
        CustomNavigationBar(backAction: backAction)
    }
    
    private var mapView: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: [viewModel.feature]) { feature in
            MapAnnotation(coordinate: feature.geometry.coordinates) {
                anotationView(feature)
            }
        }
    }
    
    private func anotationView(_ feature: Feature) -> some View {
        HStack(spacing: 5) {
            Image("Bike")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(5)
                .background(Circle().fill(Color.white))
            
            Text(feature.properties.bikes)
                .font(.title2.bold())
                .foregroundColor(Color.customGreen)
        }
    }
    
    private var detailsCell: some View {
        BikeStationCell(feature: viewModel.feature, userLocation: $viewModel.userLocation)
    }
    
    // MARK: - Actions
    private func backAction() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct StationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailsView(viewModel: StationDetailsViewModel(feature: .mock))
    }
}
