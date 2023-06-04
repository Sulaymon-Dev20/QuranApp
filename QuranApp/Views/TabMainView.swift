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
    @EnvironmentObject var spotlightManager: SpotlightManager
    
    var body: some View {
        TabView(selection: $routerManager.tabValue) {
            SurahView()
                .tabItem {
                    Image(systemName: "book.circle")
                    Text("surahs")
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
        .overlay(alignment: .bottom, content: {
            HStack(spacing: 0, content: {
                Circle()
                    .foregroundColor(.clear)
                    .frame(width: 45, height: 45)
                    .showCase(order: 3, title: "String dasfd", cornerRadius: 10, style: .continuous)
                    .frame(maxWidth: .infinity)

                Circle()
                    .foregroundColor(.clear)
                    .frame(width: 45, height: 45)
                    .showCase(order: 4, title: "String fdsf", cornerRadius: 10, style: .continuous)
                    .frame(maxWidth: .infinity)

                Circle()
                    .foregroundColor(.clear)
                    .frame(width: 45, height: 45)
                    .showCase(order: 5, title: " fff String", cornerRadius: 10, style: .continuous)
                    .frame(maxWidth: .infinity)
            })
            .allowsTightening(false)
        })
        .modifier(ShowCaseRoot(showHighlights: true, onFinished: {
            print("finished OnBoarding")
        }))
        .onAppear {
            spotlightManager.showSpotLight = true
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
            .environmentObject(SpotlightManager())
    }
}
