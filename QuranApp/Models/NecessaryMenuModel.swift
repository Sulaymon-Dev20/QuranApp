//
//  NecessaryMenuModel.swift
//  QuranApp
//
//  Created by Sulaymon on 16/06/23.
//

import Foundation
import Lottie

struct NecessaryMenuModel: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subTitle: String?
    var button: String
    var lottieView: LottieAnimationView = .init()
    var isFill: Bool = false
    var loop: Bool = false
    var link: URL
}
