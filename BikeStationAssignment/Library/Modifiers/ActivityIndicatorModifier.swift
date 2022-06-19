//
//  ActivityIndicatorModifier.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 19.06.2022.
//

import SwiftUI

struct ActivityIndicatorModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isLoading ? 3: 0)
                .disabled(isLoading)
            if isLoading {
                ActivityIndicator(isAnimating: $isLoading, color: .gray, style: .large)
            }
        }
    }
}
