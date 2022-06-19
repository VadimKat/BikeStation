//
//  CustomNavigationBar.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    let isBackButtonEnabled: Bool
    var backAction: () -> Void
    
    private var navigationBarHeight: CGFloat {
        UIDevice.current.hasTopNotch ? 80 : 50
    }
    
    private var backButtonTopPadding: CGFloat {
        UIDevice.current.hasTopNotch ? 30 : 5
    }
    
    init(isBackButtonEnabled: Bool = true,
         backAction: @escaping () -> Void = {}) {
        self.isBackButtonEnabled = isBackButtonEnabled
        self.backAction = backAction
    }
    
    var body: some View {
        HStack {
            backButton
            Spacer()
        }
        .frame(height: navigationBarHeight)
        .background(Color.black)
    }
    
    @ViewBuilder private var backButton: some View {
        if isBackButtonEnabled {
            Button(action: backAction) {
                Image(systemName: "arrow.left")
                    .font(.title2.bold())
                    .foregroundColor(Color.white)
                    .padding(.leading)
                    .padding(.top, backButtonTopPadding)
            }
        }
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar()
    }
}
