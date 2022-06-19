//
//  LocationManager.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 19.06.2022.
//

import Foundation
import CoreLocation

extension LocationManager {
    enum LocationManagerError: LocalizedError {
        case userPositionDenied
        case userPositionRestricted
        case error(Error)
        
        var errorDescription: String? {
            switch self {
            case .userPositionDenied:
                return ""
            case .userPositionRestricted:
                return "Your location detection is restricted. To get best accuracy results please enable it for best result"
            case let .error(error):
                return error.localizedDescription
            }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationError: LocationManagerError?
    @Published var userLocation: CLLocationCoordinate2D?
    
    let locationManager = CLLocationManager()
    
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        locationManager.delegate = self
        requestAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            requestAuthorization()
        case .denied:
            locationError = .userPositionDenied
        case .restricted:
            locationError = .userPositionRestricted
        default:
            requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = .error(error)
    }
    
    func requestAuthorization() {
        CLLocationManager().requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
}
