//
//  BookmarkSwipe.swift
//  QuranApp
//
//  Created by Sulaymon on 02/06/23.
//

import SwiftUI

struct BookmarkSwipe: View {
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel

    let item: BookmarkModel
    let status: Bool

    var body: some View {
        Button {
            bookmarksViewModel.saveOrDelete(item: item)
        } label: {
            Label("Choose", systemImage: status ? "bookmark.slash.fill" : "bookmark.fill")
        }
    }
}

struct BookmarkSwipe_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkSwipe(item: BookmarkModel(title: "asdf", juz: "asdf", pageNumber: 12),status: false)
            .environmentObject(BookMarkViewModel())
    }
}
