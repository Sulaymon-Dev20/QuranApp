//
//  ListEmptyView.swift
//  QuranApp
//
//  Created by Sulaymon on 25/05/23.
//

import SwiftUI

struct ListEmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "folder.fill.badge.questionmark")
                .font(.largeTitle)
                .padding(20)
            Text("cannot_find")
                .bold()
        }
    }
}

struct ListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyView()
    }
}
