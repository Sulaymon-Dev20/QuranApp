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
                                            PDFViewUI(pageNumber: item.pageNumber, permessionBookmarkButton: true, hiddenBar: $hiddenBar)
                                .onAppear {
                                    self.hiddenBar = true
                                }
                            ) {
                                Text(">>>")
                            }
                            .opacity(0)
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
        BookmarkListView(list: [], selectedTab: .constant(1), hiddenBar: .constant(false))
            .environmentObject(BookMarkViewModel())
    }
}
