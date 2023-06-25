//
//  BookmarkListView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkListView: View {
    let list: [BookmarkModel]
    
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    @EnvironmentObject var routerManager: RouterManager
    
    var body: some View {
        if !bookmarksViewModel.items.isEmpty {
            if !list.isEmpty {
                ForEach(routerManager.sort ? list : list.reversed()) { item in
                    BookmarkRowView(item: item)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                            BookmarkSwipe(item: item, status: true)
                                .tint(.red)
                        })
                        .swipeActions(edge: .leading) {
                            ShareSwipe(title: LocalizedStringKey(item.title).stringValue(), index: item.pageNumber)
                        }
                }
                .onDelete(perform: bookmarksViewModel.deleteItem)
                .onMove { indexA, indexB in
                    var reversed = Array(routerManager.sort ? bookmarksViewModel.items : bookmarksViewModel.items.reversed())
                    reversed.move(fromOffsets: indexA, toOffset: indexB)
                    bookmarksViewModel.items = routerManager.sort ? reversed : reversed.reversed()
                }
            } else {
                ItemNotFoundView()
            }
        } else {
            Button {
                routerManager.pushTab(to: 0)
            } label: {
                ListEmptyView(icon: "book.circle", text: "bookmark_does_not_have_yet")
                    .frame(maxWidth: .infinity)
            }
        }
    }
}


struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookmarkListView(list: [])
        }
        .environmentAllObject()
    }
}
