//
//  CLLocationCoordinate2D+Extensions.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 19.06.2022.
//

import Foundation
import CoreLocation
import UIKit

extension CLLocationCoordinate2D: Equatable {
    static public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
