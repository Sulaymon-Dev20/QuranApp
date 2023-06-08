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

    let list: [BookmarkModel]
    
    @Binding var sort: Bool
    @Binding var searchText: String

    @State var nativationStatus: Bool = false
    @State var showAlert: Bool = false

    var body: some View {
        Section("Bookmark") {
            if !list.isEmpty {
                ForEach(sort ? list : list.reversed()) { item in
                    BookmarkRowView(title: item.title, juz: item.juz, pageNumber: item.pageNumber)
                        .overlay {
                            NavigationLink(value: Route.menu(item: item)) {
                                Text(">>>")
                            }
                            .opacity(0)
                        }
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
                    if searchText.count == 0 {
                        var reversed = Array(sort ? list : list.reversed())
                        reversed.move(fromOffsets: indexA, toOffset: indexB)
                        bookmarksViewModel.items = sort ? reversed : reversed.reversed()
                    }
                }
            } else {
                ListEmptyView(icon: "book.circle", text: "bookmark_does_not_have_yet")
                    .onTapGesture {
                        routerManager.pushTab(to: 0)
                    }
                    .frame(maxWidth: .infinity)
            }
        }
    }
}


struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookmarkListView(list: [], sort: .constant(false), searchText: .constant(""))
        }
        .environmentObject(BookMarkViewModel())
        .environmentObject(RouterManager())
        .environmentObject(NotificatSurahViewModel())
        .environmentObject(NoficationsManager())
        .environmentObject(PrayerTimeManager())
    }
}
