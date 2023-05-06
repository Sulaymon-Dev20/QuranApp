//
//  BookmarkView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel

    @State private var searchBarStatus = false
    @State private var searchText: String = ""

    @State var sort: Bool = false
    @State var degree: Double = 0

    @Binding var selectedTab: Int
    @Binding var hiddenBar: Bool
        
    var body: some View {
        NavigationStack {
            BookmarkListView(list: filterData(), selectedTab: $selectedTab, hiddenBar: $hiddenBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(hiddenBar ? .hidden : .visible, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("bookmarks")
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        LanguageButtonView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !bookmarksViewModel.items.isEmpty{
                            Button {
                                if searchBarStatus {
                                    searchText = ""
                                }
                                searchBarStatus = !searchBarStatus
                            } label: {
                                Image(systemName: searchBarStatus ? "trash.slash.fill" : "magnifyingglass")
                            }
                        }
                    }
                }
//                .searchable(text: $searchText, placement: .toolbar, prompt: Text("search_bookmark"))
        }
    }
    
    func filterData() -> [BookmarkModel] {
        if searchText.count > 0 {
            return bookmarksViewModel.items.filter { item in
                item.toString().lowercased().contains(searchText.lowercased())
            }
        } else {
            return bookmarksViewModel.items
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView(selectedTab: .constant(1), hiddenBar: .constant(false))
            .environmentObject(BookMarkViewModel())
            .environmentObject(LanguageViewModel())
        //            .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
