//
//  View.swift
//  QuranApp
//
//  Created by Sulaymon on 27/05/23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func forceRotation(orientation: UIInterfaceOrientationMask) -> some View {
        self.onAppear() {
            MyAppDelegate.orientationLock = orientation
        }
    }
    
    @ViewBuilder
    func hiddinNativiation(value: Route) -> some View {
        self
            .overlay {
                NavigationLink(value: value) {
                    Text(">>>")
                }
                .opacity(0)
            }
    }
    
    
    @ViewBuilder
    func hideIfPad() -> some View {
        if UIDevice.current.userInterfaceIdiom != .pad {
            self
        }
    }
    
    @ViewBuilder
    func navigationButton(action event: @escaping () -> Void) -> some View {
        Button {
            event()
        } label: {
            self
        }
        .foregroundColor(Color.primary)
    }
}

