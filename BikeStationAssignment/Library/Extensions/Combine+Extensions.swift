//
//  Combine+Extensions.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import Foundation
import Combine

extension Publisher where Self.Failure == Never {

    func assignWeak<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root?) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
