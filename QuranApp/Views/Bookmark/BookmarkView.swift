//
//  BookmarkView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    @EnvironmentObject var routerManager: RouterManager
    
    @State var searchText: String = ""
    
    @State var sort: Bool = false
    @State var degree: Double = 0
    
    var body: some View {
        NavigationStack {
            List {
                BookmarkListView(list: filterData(), sort: $sort, searchText: $searchText)
                NotificationView()
                PrayTimeRowView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("bookmarks")
            .toolbar(routerManager.tabBarHideStatus ? .hidden : .visible, for: .tabBar)
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
            .navigationDestination(for: Int.self) { pageNumber in
                PDFViewUI(pageNumber: pageNumber)
                    .onAppear {
                        routerManager.tabBarHide(status: true)
                    }
            }
        }
        .onDisappear {
            searchText = ""
        }
    }
    
    func filterData() -> [BookmarkModel] {
        if searchText.count > 0 {
            return bookmarksViewModel.items.filter {$0.toString().lowercased().contains(searchText.lowercased())}
        } else {
            return bookmarksViewModel.items
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
            .previewDevice("iPhone 14 Pro Max")
            .environmentObject(BookMarkViewModel())
            .environmentObject(LanguageViewModel())
            .environmentObject(RouterManager())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(PrayerTimeManager())
            .environmentObject(NoficationsManager())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(LocationManager())
        //            .environment(\.locale, Locale.init(identifier: "ar"))
//            .preview(for: .iPhone)
    }
}
