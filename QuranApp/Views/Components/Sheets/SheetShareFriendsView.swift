//
//  SheetShareFriendsView.swift
//  QuranApp
//
//  Created by Sulaymon on 20/06/23.
//

import SwiftUI
import Lottie

struct SheetShareFriendsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var reviewsRequestManager: ReviewsRequestManager

    @State private var animation:LottieAnimationView = LottieAnimationView(name: "Share", bundle: .main)
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            VStack {
                ResizableLottieView(onboarding: $animation)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                Text("Share")
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .bold()
                    .font(.title)
                Text("subTitle")
                        .multilineTextAlignment(.center)
                        .font(.callout)
                ShareLink(item: reviewsRequestManager.reviewLink!, subject: Text("Holy book application link"), message: Text("Quran is healing for believers")) {
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

struct ShareFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        SheetShareFriendsView()
            .environmentObject(ReviewsRequestManager())
    }
}
