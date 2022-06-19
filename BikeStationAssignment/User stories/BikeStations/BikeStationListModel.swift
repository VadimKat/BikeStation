//
//  BikeStationListModel.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import Foundation
import CoreLocation

// MARK: - BikeStationListModel
struct BikeStationListModel: Decodable {
    let features: [Feature]
}

// MARK: - Feature
struct Feature: Decodable, Identifiable {
    let geometry: Geometry
    let id: String
    let properties: FeatureProperties
}

extension Feature {
    static var mock: Feature {
        loadJSON(from: "Feature_mock", bundle: .main)!
    }
}

// MARK: - Geometry
struct Geometry: Decodable {
    let coordinates: CLLocationCoordinate2D
    
    func distance(userLocation: CLLocationCoordinate2D?) -> CLLocationDistance {
        guard let userLocation = userLocation else { return .zero }
        return coordinates.distance(to: userLocation)
    }
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let _coordinates = try values.decode([Double].self, forKey: .coordinates)
        self.coordinates = CLLocationCoordinate2D(latitude: _coordinates[1], longitude: _coordinates[0])
    }
}
// MARK: - FeatureProperties
struct FeatureProperties: Decodable {
    let freeRacks, bikes, label, bikeRacks: String
    let updated: String
    
    enum CodingKeys: String, CodingKey {
        case freeRacks = "free_racks"
        case bikes, label
        case bikeRacks = "bike_racks"
        case updated
    }
}

