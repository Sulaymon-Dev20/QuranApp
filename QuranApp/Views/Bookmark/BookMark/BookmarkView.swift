//
//  BookmarkView.swift
//  QuranApp
//
//  Created by Sulaymon on 26/06/23.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    @EnvironmentObject var routerManager: RouterManager
    
    var body: some View {
        Section {
            BookmarkListView(list: filterData())
        } header: {
            HStack {
                Text("bookmarks")
                Spacer()
                SortButtonView(sort: $routerManager.sort)
            }
        }
    }
    
    func filterData() -> [BookmarkModel] {
        if routerManager.searchText.count > 0 {
            return bookmarksViewModel.items.filter {
                return LocalizedStringKey($0.title.localizedForm).stringValue().lowercased().contains(routerManager.searchText.lowercased())
            }
        } else {
            return bookmarksViewModel.items
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
            .environmentAllObject()
    }
}
