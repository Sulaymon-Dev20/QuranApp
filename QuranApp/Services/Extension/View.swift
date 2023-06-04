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
    func reverseMask<Content: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .mask {
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}
