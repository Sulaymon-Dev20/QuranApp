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
    @EnvironmentObject var necessaryMenuViewModel: NecessaryMenuViewModel
    
    var body: some View {
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
            //                if badgeAppManager.count != 0 {
            //                    badgeAppManager.setBadge(number: 0)
            //                }
        }
        .task {
            noficationsManager.checkNotificationPermission()
        }
        .sheet(isPresented: $necessaryMenuViewModel.showModel) {
            necessaryMenuViewModel.sheetDestination()
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
            .environmentObject(NecessaryMenuViewModel())
    }
}
