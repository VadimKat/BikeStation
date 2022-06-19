//
//  CLLocation+Extensions.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 19.06.2022.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func distance(to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to)
    }
}
