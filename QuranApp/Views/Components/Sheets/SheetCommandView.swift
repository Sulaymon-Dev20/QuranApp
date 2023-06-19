//
//  SheetCommandView.swift
//  QuranApp
//
//  Created by Sulaymon on 20/06/23.
//

import SwiftUI
import Lottie

struct SheetCommandView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var reviewsRequestManager: ReviewsRequestManager
    
    @State private var animation:LottieAnimationView = LottieAnimationView(name: "Commant", bundle: .main)
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            VStack {
                ResizableLottieView(onboarding: $animation)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                Text("Commandlar")
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .bold()
                    .font(.title)
                Text("subTitle")
                    .multilineTextAlignment(.center)
                    .font(.callout)
                Button {
                    if let link = reviewsRequestManager.reviewLink {
                        UIApplication.shared.open(link, options: [:])
                    }
                    dismiss()
                } label: {
                    Text("share")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
                
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(
                Rectangle()
                    .foregroundColor(Color.dynamicColor)
            )
            .cornerRadius(25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .background(
            Color.primary.opacity(0.15)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismiss()
                }
        )
        .onAppear {
            animation.play(toProgress: 1, loopMode: .loop)
        }
    }
}

struct SheetCommandView_Previews: PreviewProvider {
    static var previews: some View {
        SheetCommandView()
            .environmentObject(ReviewsRequestManager())
    }
}
