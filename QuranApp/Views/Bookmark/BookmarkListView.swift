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
    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel
    
    let list: [BookmarkModel]
    
    @Binding var sort: Bool
    @Binding var searchText: String
    
    var body: some View {
        List {
            Section("Bookmark") {
                if !list.isEmpty {
                    ForEach(sort ? list : list.reversed()) { item in
                        BookmarkRowView(title: item.title, juz: item.juz, pageNumber: item.pageNumber)
                            .overlay{
                                NavigationLink(destination:
                                                PDFViewUI(pageNumber: item.pageNumber)
                                    .onAppear {
                                        routerManager.tabBarHide(status: true)
                                    }
                                ) {
                                    Text(">>>")
                                }
                                .opacity(0)
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    bookmarksViewModel.saveOrDelete(item: BookmarkModel(title: item.title, juz: item.juz, pageNumber: item.pageNumber))
                                } label: {
                                    Label("Choose", systemImage: "bookmark.slash")
                                }
                                .tint(.red)
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
                    BookmarkEmptyView()
                        .onTapGesture {
                            routerManager.pushTab(to: 0)
                        }
                        .frame(maxWidth: .infinity)
                }
            }
            Section("Notifications") {
                if !notificatSurahViewModel.items.isEmpty {
                    ForEach(notificatSurahViewModel.items, id: \.id) { item in
                        Toggle(isOn: .constant(false)) {
                            Text(item.title)
                        }
                    }
                    .onDelete(perform: notificatSurahViewModel.deleteItem)
                } else {
                    BookmarkEmptyView()
                        .frame(maxWidth: .infinity)
                }
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
    }
}
