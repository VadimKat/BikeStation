//
//  StationDetailsViewModel.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import Foundation
import Combine
import MapKit

class StationDetailsViewModel: ObservableObject {
    @Published var feature: Feature
    @Published var region: MKCoordinateRegion
    @Published var userLocation: CLLocationCoordinate2D?
    
    private let locationManager: LocationManager
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(feature: Feature,
         locationManager: LocationManager = .shared) {
        self.feature = feature
        self.locationManager = locationManager
        self.region = MKCoordinateRegion(center: feature.geometry.coordinates,
                                         span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        
        setupBindings()
    }
    
    private func setupBindings() {
        locationManager.$userLocation
            .removeDuplicates()
            .compactMap { $0 }
            .compactMap { [weak self] userLocation in
                return self?.centerBetweenAnnotationAnd(userLocation: userLocation)
            }
            .map { rect in
                var region = MKCoordinateRegion(rect)
                region.span = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * 1.2, longitudeDelta: region.span.longitudeDelta * 1.2)
                return region
            }
            .assignWeak(to: \.region, on: self)
            .store(in: &subscriptions)
        
        locationManager.$userLocation
            .removeDuplicates()
            .assignWeak(to: \.userLocation, on: self)
            .store(in: &subscriptions)
    }
    
    
    private func centerBetweenAnnotationAnd(userLocation: CLLocationCoordinate2D) -> MKMapRect {
        let userPoint = MKMapPoint(userLocation)
        let annotationPoint = MKMapPoint(feature.geometry.coordinates)
        return MKMapRect(x: min(userPoint.x, annotationPoint.x),
                         y: min(userPoint.y, annotationPoint.y),
                         width: abs(userPoint.x - annotationPoint.x),
                         height: abs(userPoint.y - annotationPoint.y))
    }
    
}
