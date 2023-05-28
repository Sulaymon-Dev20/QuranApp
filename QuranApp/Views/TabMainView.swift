//
//  TabViewMain.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct TabMainView: View {
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var badgeAppManager: BadgeAppManager
 
    var body: some View {
        ZStack {
            TabView(selection: $routerManager.tabValue) {
                SurahView()
                    .tabItem {
                        Label("surahs", systemImage: "book.circle")
                    }
                    .tag(0)
                JuzView()
                    .tabItem {
                        Label("juz", systemImage: "mountain.2.circle.fill")
                    }
                    .tag(1)
                BookmarkView()
                    .badge(badgeAppManager.count)
                    .tabItem {
                        Label("bookmarks", systemImage: "bookmark.circle")
                    }
                    .tag(2)
            }
            .accentColor(Color.primary)
            .toolbarRole(ToolbarRole.automatic)
        }
    }
}

struct TabMainView_Previews: PreviewProvider {
    static var previews: some View {
        TabMainView()
            .environmentObject(SurahViewModel())
            .environmentObject(LaunchScreenViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(LocationManager())
            .environmentObject(NoficationsManager())
            .environmentObject(LanguageViewModel())
            .environmentObject(RouterManager())
            .environmentObject(JuzViewModel())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(PrayerTimeManager())
            .environmentObject(ReviewsRequestManager())
            .environmentObject(BadgeAppManager())
    }
}
