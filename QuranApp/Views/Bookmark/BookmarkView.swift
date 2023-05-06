//
//  BookmarkView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel

    @State private var searchText: String = ""

    @State var sort: Bool = false
    @State var degree: Double = 0

    @Binding var selectedTab: Int
    @Binding var hiddenBar: Bool
        
    var body: some View {
        NavigationStack {
            BookmarkListView(list: sort ? filterData() : filterData().reversed(), selectedTab: $selectedTab, hiddenBar: $hiddenBar)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("bookmarks")
                .toolbar(hiddenBar ? .hidden : .visible, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        LanguageButtonView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                self.sort = !sort
                                degree += 180
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .rotationEffect(.degrees(degree))
                                .animation(.linear(duration: 0.3), value: sort)
                            
                        }
                    }
                }
                .searchable(text: $searchText, placement: .toolbar, prompt: Text("search_bookmark"))
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
