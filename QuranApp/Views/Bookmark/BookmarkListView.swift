//
//  BookmarkListView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkListView: View {
    let list: [BookmarkModel]
    @Binding var selectedTab: Int
    @Binding var hiddenBar: Bool
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    
    var body: some View {
        if !list.isEmpty {
            List {
                ForEach(list) { item in
                    BookmarkRowView(title: item.title, juz: item.juz, pageNumber: item.pageNumber)
                        .overlay{
                            NavigationLink(destination:
                                            PDFViewUI(pageNumber: item.pageNumber, hiddenBar: $hiddenBar)
                                .onAppear {
                                    self.hiddenBar = true
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
                .onMove(perform: bookmarksViewModel.moveItem)
            }
        } else {
            if bookmarksViewModel.items.isEmpty {
                BookmarkEmptyView()
                    .onTapGesture {
                        selectedTab = 0
                    }
            } else {
                ListEmptyView()
            }
        }
    }
}

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookmarkListView(list: [], selectedTab: .constant(1), hiddenBar: .constant(false))
                .environmentObject(BookMarkViewModel())
        }
    }
}
