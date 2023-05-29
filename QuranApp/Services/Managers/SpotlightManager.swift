//
//  SpotlightManager.swift
//  QuranApp
//
//  Created by Sulaymon on 30/05/23.
//

import Foundation

class SpotlightManager: ObservableObject {
    @Published var currentSpot: Int = 0
//    @Published var showSpotLight: Bool = false
    @Published var showSpotLight: Bool = true
}
