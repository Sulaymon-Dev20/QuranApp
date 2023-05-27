//
//  ListEmptyView.swift
//  QuranApp
//
//  Created by Sulaymon on 27/05/23.
//

import SwiftUI

struct ListEmptyView: View {
    let icon:String
    let text:LocalizedStringKey
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 60))
                .padding(1)
            Text(text)
                .frame(width: 160)
                .multilineTextAlignment(.center)
                .bold()
        }
    }
}

struct ListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyView(icon: "book.circle", text: "bookmark_does_not_have_yet")
    }
}
