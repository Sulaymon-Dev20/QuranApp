//
//  BookmarkView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var noficationsManager: NoficationsManager
    @EnvironmentObject var badgeAppManager: BadgeAppManager
    
    var body: some View {
        NavigationStack(path: self.$routerManager.path) {
            ScrollViewReader { proxy in
                List {
                    LastPageView()
                        .id(0)
                    BookmarkListView()
                        .id(1)
                    NotificationView()
                        .id(2)
                    PrayTimeRowView()
                        .id(3)
                    ColorSchemeView()
                        .id(4)
                }
                .onAppear {
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
                    NecessaryButton()
                }
            }
            .navigationDestination(for: Route.self) {
                routerManager.navigationDestination($0)
            }
        }
        .task {
            noficationsManager.checkNotificationPermission()
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
            .environmentObject(ColorSchemeManager())
            .environmentObject(SurahViewModel())
    }
}
