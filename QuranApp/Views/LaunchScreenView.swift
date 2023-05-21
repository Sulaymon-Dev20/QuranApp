//
//  LaunchScreenView.swift
//  QuranApp
//
//  Created by Sulaymon on 22/05/23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var launchScreenViewModel: LaunchScreenViewModel
    
    @State private var firstPhaseIsAnimating:Bool = false
    @State private var secondPhaseIsAnimating:Bool = false
    
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            background
            VStack{
                logo
                Text("launchScreenTitle")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, -40)
            }
        }.onReceive(timer) { input in
            switch launchScreenViewModel.state {
            case .first:
                withAnimation {
                    firstPhaseIsAnimating.toggle()
                }
            case .second:
                withAnimation {
                    secondPhaseIsAnimating.toggle()
                }
            default: break
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenViewModel())
    }
}

private extension LaunchScreenView{
    var background:some View {
        Color("LaunchScreenBackground")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo:some View{
        Image("logo")
            .scaleEffect(firstPhaseIsAnimating ? 0.6 : 1)
            .scaleEffect(secondPhaseIsAnimating ? UIScreen.main.bounds.height / 4 : 1)
    }
}
