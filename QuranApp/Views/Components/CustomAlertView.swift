//
//  CustomAlertView.swift
//  QuranApp
//
//  Created by Sulaymon on 29/05/23.
//

import SwiftUI

struct CustomAlertViewTest: View {
    @State var show: Bool = false

    var body: some View {
        VStack {
            CustomAlertView(show: $show)
                .opacity(show ? 10 : 0)
            Button("asdf") {
                show.toggle()
            }
        }
//        .ignoresSafeArea(.all)
    }
}

struct CustomAlertView: View {
    @Binding var show: Bool

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack(spacing: 25) {
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(size: 100))
                Text("nimadir nimadir ")
                    .font(.title)
                    .foregroundColor(.pink)
                Text("nimadir nimadir kattorq nimadir ")
                Button {
                    
                } label: {
                    Text("Buttton")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .padding(.horizontal, 25)
                        .background(Color.purple)
                        .cornerRadius(20)
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
            Button {
                withAnimation {
                    show.toggle()
                }
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.purple)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
        )
    }
}

struct BlurView: UIViewRepresentable { 
    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view  = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}


struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertViewTest()
    }
}
