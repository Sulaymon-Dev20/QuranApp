//
//  onBoardingModel.swift
//  QuranApp
//
//  Created by Sulaymon on 29/05/23.
//

import SwiftUI
import Lottie

struct OnBoardingModel: Identifiable, Equatable {
    var id: UUID = .init()
    var title: LocalizedStringKey
    var subTitle: LocalizedStringKey
    var lottieView: LottieAnimationView = .init()
    var loop: Bool = false
}
