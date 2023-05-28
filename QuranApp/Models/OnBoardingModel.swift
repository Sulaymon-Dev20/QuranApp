//
//  onBoardingModel.swift
//  QuranApp
//
//  Created by Sulaymon on 29/05/23.
//

import Foundation
import Lottie

struct OnBoardingModel: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var lottieView: LottieAnimationView = .init()
}
