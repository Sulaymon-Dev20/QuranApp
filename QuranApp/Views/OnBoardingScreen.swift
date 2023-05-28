//
//  OnBoardingScreen.swift
//  QuranApp
//
//  Created by Sulaymon on 29/05/23.
//

import SwiftUI
import Lottie

struct OnBoardingScreen: View {
    @State var onboardingItems: [OnBoardingModel] = [
        .init(title: "Xorijiy Tillar",
              subTitle: "Iltimos o`zingizga qulay bo`lishi uchun tilni tanlang",
              lottieView: .init(name:"Language", bundle: .main)),
        .init(title: "Eslatma tizimi",
              subTitle: "ushbu ilovada siz aynan bir surani kunning istalgan qismni belgilab eslatma qoldirishingiz mumkin",
              lottieView: .init(name:"Notification", bundle: .main)),
        .init(title: "Nomoz vaqtlari",
              subTitle: "ilovada qulaylik uchun nomoz vaqtlar ham mabjud va siz aynan bir surani nomoz vaqtiga qarab esmani bergilashingiz mumkin",
              lottieView: .init(name:"Clock", bundle: .main)),
        .init(title: "Qurani karim",
              subTitle: "ushbu ilovaning asosiy maqsadi ham qurani karim bo`lib offline ishlari uchun qo`ldan kelgancha harakat qilingan !",
              lottieView: .init(name:"Book", bundle: .main))
    ]
    
    @State var currentIndex: Int = 0
    @EnvironmentObject var reviewsManager: ReviewsRequestManager
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            HStack(spacing: 0) {
                ForEach($onboardingItems) { $item in
                    VStack {
                        HStack {
                            Button("Back"){
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            }
                            Spacer(minLength: 0)
                            Button("Skip"){
                                currentIndex = onboardingItems.count - 1
                            }
                        }
                        .tint(Color.red)
                        .bold()
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            ResizableLottieView(onboardingItem: $item)
                                .frame(height: size.width)
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
                            Text(finalPage ? "Start" : "Mext")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(Color.red)
                                }
                                .padding(.horizontal, 100)
                                .onTapGesture {
                                    if currentIndex < onboardingItems.count - 1 {
                                        currentIndex += 1
                                        onboardingItems[currentIndex].lottieView.currentProgress = 0
                                        onboardingItems[currentIndex].lottieView.play(toProgress: 1, loopMode: .loop)
                                    } else {
                                        reviewsManager.increase()
                                    }
                                }
                            HStack {
                                Text("Teams of Service")
                                Text("Privary Policy")
                            }
                            .font(.caption2)
                            .underline(true, color: .primary)
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
            .environmentObject(ReviewsRequestManager())
            .environmentObject(LanguageViewModel())
    }
}

struct ResizableLottieView: UIViewRepresentable {
    
    @Binding var onboardingItem: OnBoardingModel
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
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
