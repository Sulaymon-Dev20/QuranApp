//
//  SortButtonView.swift
//  QuranApp
//
//  Created by Sulaymon on 02/06/23.
//

import SwiftUI

struct SortButtonView: View {

    @Binding var sort: Bool
    @State var degree: Double = 0

    var body: some View {
        Button {
            withAnimation {
                self.sort = !sort
                degree += 180
            }
        } label: {
            Image(systemName: "arrow.up")
                .rotationEffect(.degrees(degree))
                .animation(.linear(duration: 0.3), value: sort)
        }
    }
}

struct SortButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SortButtonView(sort: .constant(false))
    }
}
