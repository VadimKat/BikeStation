//
//  BikeStationCell.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import SwiftUI
import CoreLocation

struct BikeStationCell: View {
    let feature: Feature
    @Binding var userLocation: CLLocationCoordinate2D?
    
    var distanceToStation: String {
        String(format: "%.0f", feature.geometry.distance(userLocation: userLocation))
    }
    
    var body: some View {
        VStack(spacing: 3) {
            headerView
            subHeaderView
            countsView
        }
        .padding(.top, 8)
        .padding(.horizontal)
    }
    
    private var headerView: some View {
        HStack {
            Text(feature.properties.label)
                .font(.title3.bold())
                .foregroundColor(Color.black)
            Spacer()
        }
    }
    
    private var subHeaderView: some View {
        HStack(spacing: 5) {
            Text("\(distanceToStation)m")
                .font(.subheadline)
                .foregroundColor(Color.black)
            
            Circle()
                .fill(Color.black.opacity(0.3))
                .frame(width: 4, height: 4)
            
            Text("Bike station")
                .font(.subheadline)
                .foregroundColor(Color.black.opacity(0.7))
            
            Spacer()
        }
    }
    
    private var countsView: some View {
        HStack {
            reusableCountView(iconName: "Bike", title: "Available bikes", number: feature.properties.bikes, color: Color.customGreen)
            
            reusableCountView(iconName: "Lock", title: "Available places", number: feature.properties.freeRacks, color: Color.customDarkGrey)
        }
        .padding(.top)
    }
    
    private func reusableCountView(iconName: String,
                                   title: String,
                                   number: String,
                                   color: Color) -> some View {
        VStack {
            Image(iconName)
                .resizable()
                .frame(width: 25, height: 25)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color.black.opacity(0.7))
            
            Text(number)
                .font(.system(size: 50).bold())
                .foregroundColor(color)
        }
    }
}

struct BikeStationCell_Previews: PreviewProvider {
    static var previews: some View {
        BikeStationCell(feature: .mock, userLocation: .constant(nil))
            .padding()
    }
}
