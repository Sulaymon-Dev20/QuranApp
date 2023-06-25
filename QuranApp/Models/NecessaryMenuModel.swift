//
//  NecessaryMenuModel.swift
//  QuranApp
//
//  Created by Sulaymon on 16/06/23.
//

import SwiftUI
import Lottie

struct NecessaryMenuModel {
    var id: UUID = .init()
    var title: String
    var subTitle: String?
    var button: String
    var lottieView: LottieAnimationView = .init()
    var isFill: Bool = false
    var loop: Bool = false
    var action: () -> Void
}
