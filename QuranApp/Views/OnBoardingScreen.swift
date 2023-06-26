//
//  OnBoardingScreen.swift
//  QuranApp
//
//  Created by Sulaymon on 29/05/23.
//

import SwiftUI
import Lottie

struct OnBoardingScreen: View {
    @EnvironmentObject var reviewsManager: ReviewsRequestManager
    
    @State var onboardingItems: [OnBoardingModel] = [
        .init(title: "languageViewTitle",
              subTitle: "languageViewSubTitle",
              lottieView: .init(name:"Language", bundle: .main),
              loop: true),
        .init(title: "clockViewTitle",
              subTitle: "clockViewSubTitle",
              lottieView: .init(name:"Notification", bundle: .main)),
        .init(title: "prayTimeViewTitle",
              subTitle: "prayTimeViewSubTitle",
              lottieView: .init(name:"Clock", bundle: .main),
              loop: true),
        .init(title: "holyBookViewTitle",
              subTitle: "holyBookViewSubTitle",
              lottieView: .init(name:"Book", bundle: .main))
    ]
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            HStack(spacing: 0) {
                ForEach($onboardingItems) { $item in
                    VStack {
                        HStack {
                            Button("back"){
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            }
                            Spacer(minLength: 0)
                            Button("skip"){
                                currentIndex = onboardingItems.count - 1
                            }
                        }
                        .tint(Color.red)
                        .bold()
                        Spacer()
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            ResizableLottieView(onboarding: $item.lottieView)
                                .frame(height: size.width / 3)
                                .onAppear {
                                    if currentIndex == indexOf(item) {
                                        onboardingItems[currentIndex].lottieView.play(toProgress: 1)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                            Text(item.subTitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }
                        .frame(maxWidth: .infinity)
                        Spacer()
                        VStack(spacing: 15) {
                            let finalPage = currentIndex == onboardingItems.count - 1
                            if currentIndex == 0 {
                                LanguageButtonView(miniView: false)
                            }
                            Text(finalPage ? "open" : "next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(finalPage ? Color.blue : Color.red)
                                }
                                .padding(.horizontal, finalPage ? 40 : 100)
                                .animation(Animation.easeInOut.delay(0.4), value: finalPage)
                                .onTapGesture {
                                    if currentIndex < onboardingItems.count - 1 {
                                        currentIndex += 1
                                        onboardingItems[currentIndex].lottieView.currentProgress = 0
                                        onboardingItems[currentIndex].lottieView.play(toProgress: 1, loopMode: item.loop ? .loop : .playOnce)
                                    } else {
                                        reviewsManager.increase()
                                    }
                                }
                            HStack {
                                Text("Developer:")
                                Text("Sulaymon Yahyo")
                                    .underline(true, color: .primary)
                            }
                            .font(.caption2)
                            .offset(y: 5)
                        }
                    }
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .center)
        }
    }
    
    func indexOf(_ item: OnBoardingModel) -> Int {
        if let index = onboardingItems.firstIndex(of: item) {
            return index
        } else {
            return 0
        }
    }
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
            .environmentAllObject()
    }
}
