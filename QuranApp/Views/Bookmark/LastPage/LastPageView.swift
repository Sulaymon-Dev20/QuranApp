//
//  LastPageView.swift
//  QuranApp
//
//  Created by Sulaymon on 13/06/23.
//

import SwiftUI

struct LastPageView: View {
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var surahViewModel: SurahViewModel
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    
    var body: some View {
        let item = surahViewModel.getSurahByPage(routerManager.currentPDFPage)!
        let status = bookmarksViewModel.getPages().contains(routerManager.currentPDFPage)
        Section("lastReadPage") {
            ForEach(0...0, id: \.self) {_ in
                SurahRowView(item: item, status: status)
                    .swipeActions(edge: .trailing, allowsFullSwipe: !status) {
                        BookmarkSwipe(item: BookmarkModel(title: item.title, juz: item.juz[0].index, pageNumber: routerManager.currentPDFPage), status: status)
                            .tint(status ? .red : .green)
                    }
                    .swipeActions(edge: .leading) {
                        ShareSwipe(title: LocalizedStringKey(item.title).stringValue(), index: item.pages)
                    }
            }
        }
    }
}

struct LastPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                LastPageView()
            }
        }
        .environmentAllObject()
    }
}
