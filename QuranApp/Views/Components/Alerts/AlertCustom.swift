//
//  AlertCustom.swift
//  QuranApp
//
//  Created by Sulaymon on 16/06/23.
//

import SwiftUI
import Lottie

struct AlertCustom: View {
    @EnvironmentObject var necessaryMenuViewModel: NecessaryMenuViewModel
    @Environment (\.openURL) var openURL
    
    var body: some View {
        if necessaryMenuViewModel.showModel {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
                VStack {
                    ResizableLottieView(onboarding: $necessaryMenuViewModel.item.lottieView)
                        .aspectRatio(contentMode: necessaryMenuViewModel.item.isFill ? .fill : .fit)
                        .frame(height: 200)
                    Text(necessaryMenuViewModel.item.title)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .bold()
                        .font(.title)
                    if let subTitle = necessaryMenuViewModel.item.subTitle {
                        Text(subTitle)
                            .multilineTextAlignment(.center)
                            .font(.callout)
                    }
                    Button {
                        openURL(necessaryMenuViewModel.item.link)
                        necessaryMenuViewModel.showModel = false
                    } label: {
                        Text(necessaryMenuViewModel.item.button)
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
                        .foregroundColor(Color(red: 235, green: 235, blue: 235))
                )
                .cornerRadius(25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 30)
            .background(
                Color.primary.opacity(0.15)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        necessaryMenuViewModel.showModel = false
                    }
            )
            .onAppear {
                necessaryMenuViewModel.item.lottieView.play(toProgress: 1, loopMode: necessaryMenuViewModel.item.loop ? .loop : .playOnce)
            }
        }
    }
}

struct AlertCustom_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlertCustom()
        }
        .environmentObject(NecessaryMenuViewModel())
    }
}
