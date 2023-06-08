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
    @EnvironmentObject var noficationsManager: NoficationsManager
    @EnvironmentObject var badgeAppManager: BadgeAppManager
    
    @State var searchText: String = ""
    @State var sort: Bool = false
    
    var body: some View {
        NavigationStack(path: self.$routerManager.path) {
            ScrollViewReader { proxy in
                VStack {
                    List {
                        BookmarkListView(list: filterData(), sort: $sort, searchText: $searchText)
                            .id(1)
                        NotificationView()
                            .id(2)
                        PrayTimeRowView()
                            .id(3)
                    }
                }
                .task {
                    if badgeAppManager.count != 0 {
                        withAnimation(Animation.default.speed(0.5)) {
                            proxy.scrollTo(3)
                            badgeAppManager.setBadge(number: 0)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("bookmarks")
            .toolbar(routerManager.tabBarHideStatus ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LanguageButtonView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    SortButtonView(sort: $sort)
                }
            }
            .searchable(text: $searchText, placement: .toolbar, prompt: Text("search_bookmark"))
            .navigationDestination(for: Route.self) {
                routerManager.navigationDestination($0)
            }
        }
        .task {
            noficationsManager.checkNotificationPermission()
        }
        .onDisappear {
            searchText = ""
        }
    }
    
    func filterData() -> [BookmarkModel] {
        if searchText.count > 0 {
            return bookmarksViewModel.items.filter {LocalizedStringKey($0.title.localizedForm).stringValue().lowercased().contains(searchText.lowercased())}
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
            .environmentObject(BadgeAppManager())
        //            .environment(\.locale, Locale.init(identifier: "ar"))
        //            .preview(for: .iPhone)
    }
}
