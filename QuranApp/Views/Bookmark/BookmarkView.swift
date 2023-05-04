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
    @State private var searchFilter: String = ""
    @Binding var selectedTab: Int
    @Binding var hiddenBar: Bool
    
    var body: some View {
        NavigationView {
            BookmarkListView(list: filterData(), selectedTab: $selectedTab, hiddenBar: $hiddenBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(hiddenBar || UIDevice.current.model == "iPad" ? .hidden : .visible, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        if searchBarStatus {
                            TextField("Booked name ", text: $searchFilter)
                        } else {
                            if UIDevice.current.model == "iPad" {
                                Menu {
                                    Button {
                                        selectedTab = 0
                                    } label: {
                                        Text("surahs")
                                    }
                                    Button {
                                        selectedTab = 1
                                    } label: {
                                        Text("juz")
                                    }
                                } label: {
                                    Text("bookmarks")
                                }
                            } else {
                                Text("bookmarks")
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        LanguageButtonView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !bookmarksViewModel.items.isEmpty{
                            Button {
                                if searchBarStatus {
                                    searchFilter = ""
                                }
                                searchBarStatus = !searchBarStatus
                            } label: {
                                Image(systemName: searchBarStatus ? "trash.slash.fill" : "magnifyingglass")
                            }
                        }
                    }
                }
        }
    }
    
    func filterData() -> [BookmarkModel] {
        if searchFilter.count > 0 {
            return bookmarksViewModel.items.filter { item in
                item.toString().lowercased().contains(searchFilter.lowercased())
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
