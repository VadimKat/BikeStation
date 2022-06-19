//
//  View+Extensions.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func hideNavigationBar() -> some View {
        self
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder func trackActivity(isLoading: Binding<Bool>) -> some View {
        self
            .modifier(ActivityIndicatorModifier(isLoading: isLoading))
    }
}
