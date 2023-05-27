//
//  ItemNotFoundView.swift
//  QuranApp
//
//  Created by Sulaymon on 27/05/23.
//

import SwiftUI

struct ItemNotFoundView: View {
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

struct ItemNotFoundView_Previews: PreviewProvider {
    static var previews: some View {
        ItemNotFoundView()
    }
}
