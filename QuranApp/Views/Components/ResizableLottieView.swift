//
//  ResizableLottieView.swift
//  QuranApp
//
//  Created by Sulaymon on 19/06/23.
//

import SwiftUI
import Lottie

struct ResizableLottieView: UIViewRepresentable {
    @Binding var onboarding: LottieAnimationView

    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView) {
        let lottieView = self.onboarding
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor),
        ]
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
