//
//  AlertCustom.swift
//  QuranApp
//
//  Created by Sulaymon on 16/06/23.
//

import SwiftUI
import Lottie

struct AlertCustom: View {
    @Binding var showAlert:Bool
    
    @State var item: NecessaryMenuModel
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            VStack {
                HStack {
                    Spacer()
                        .frame(width: 300)
                    Button {
                        showAlert = false
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 28 , weight: .bold))
                            .foregroundColor(.purple)
                    }
                }
                ResizableLottieView(onboarding: $item.lottieView)
                    .scaledToFit()
                    .frame(width: .infinity, height: 200)
                Text(item.title)
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .bold()
                    .font(.title)
                if let subTitle = item.subTitle {
                    Text(subTitle)
                        .multilineTextAlignment(.center)
                        .font(.callout)
                }
                Button {
                    
                } label: {
                    Text(item.button)
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
        .background(
            Color.primary.opacity(0.15)
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            item.lottieView.play(toProgress: 1, loopMode: item.loop ? .loop : .playOnce)
        }
        .opacity(showAlert ? 1 : 0)
    }
}

struct AlertCustom_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlertCustom(
                showAlert: .constant(true),
                item: NecessaryMenuModel(title: "Commandlar",subTitle: "lekin kamchiliklarimiz bo`lsa ayting va biz uni tuzishga hakat qilamiz", button: "asdf",
                    lottieView: .init(name: "Share", bundle: .main), loop: true, link: URL(string: "asldf")!))
            //            AlertCustom(
            //                showAlert: .constant(true),
            //                item: NecessaryMenuModel(title: "Commandlar",subTitle: "lekin kamchiliklarimiz bo`lsa ayting va biz uni tuzishga hakat qilamiz", button: "asdf",
            //                                         lottieView: .init(name: "Commant", bundle: .main), link: URL(string: "asldf")!))
        }
    }
}
