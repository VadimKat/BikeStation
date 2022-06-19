//
//  Foundation+Extensions.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import Foundation

func loadJSON<T: Decodable>(from fileName: String, bundle: Bundle) -> T?{
    do {
        let path = bundle.path(forResource: fileName, ofType: "json")
        let json = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let model = try JSONDecoder().decode(T.self, from: json)
        
        return model
    } catch {
        return nil
    }
}
