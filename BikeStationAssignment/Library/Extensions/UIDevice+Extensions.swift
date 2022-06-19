//
//  UIDevice+Extensions.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import UIKit

extension UIDevice {
    var hasTopNotch: Bool {
        let bottom: CGFloat = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .compactMap{ $0.delegate as? UIWindowSceneDelegate }
            .first?.window??.safeAreaInsets.bottom ?? 0
        
        return bottom > 0
    }
}
