//
//  Test.swift
//  QuranApp
//
//  Created by Sulaymon on 15/06/23.
//

import SwiftUI

struct Test: View {
    let data = ["One"]
    @State var showListItems = false
    @State var animationDelay = 0.5
    // definitions of viewRouter, data etc.
    
    var body: some View {
        VStack {
            // other items, navLink etc.
            Toggle("Show List Items", isOn: $showListItems)
            List {
                ForEach(data.indices) { index in
                    Button(action: {

                    }, label: {
                        ZStack(alignment: .center) {
                            HStack(alignment: .center) {
                                Color.gray
                            }
                            .frame(maxWidth: showListItems ? .infinity : 34, maxHeight: .infinity, alignment: .center)
                        }
                    })
                    //                    .opacity(showListItems ? 1 : 0)
//                    .animation(Animation.easeOut(duration: 0.6).delay(animationDelay * Double(index)), value: showListItems)
                }
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
