//
//  BookmarkListView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkListView: View {
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var noficationsManager: NoficationsManager
    
    @State var sort: Bool = false
    
    var body: some View {
        Section {
            if !bookmarksViewModel.items.isEmpty {
                ForEach(sort ? bookmarksViewModel.items : bookmarksViewModel.items.reversed()) { item in
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
                    var reversed = Array(sort ? bookmarksViewModel.items : bookmarksViewModel.items.reversed())
                    reversed.move(fromOffsets: indexA, toOffset: indexB)
                    bookmarksViewModel.items = sort ? reversed : reversed.reversed()
                }
            } else {
                Button {
                    routerManager.pushTab(to: 0)
                } label: {
                    ListEmptyView(icon: "book.circle", text: "bookmark_does_not_have_yet")
                        .frame(maxWidth: .infinity)
                }
            }
        } header: {
            HStack {
                Text("bookmarks")
                Spacer()
                SortButtonView(sort: $sort)
            }
        }
    }
}


struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookmarkListView()
        }
        .environmentObject(BookMarkViewModel())
        .environmentObject(RouterManager())
        .environmentObject(NotificatSurahViewModel())
        .environmentObject(NoficationsManager())
        .environmentObject(PrayerTimeManager())
        .environmentObject(LanguageViewModel())
        .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
