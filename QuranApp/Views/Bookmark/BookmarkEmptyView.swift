//
//  BookmarkEmptyView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkEmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "book.circle")
                .font(.system(size: 60))
                .padding(1)
            Text("bookmark_does_not_have_yet")
                .frame(width: 160)
                .multilineTextAlignment(.center)
                .bold()
        }
    }
}

struct BookmarkEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkEmptyView()
    }
}
