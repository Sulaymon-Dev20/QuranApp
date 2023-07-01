//
//  BookmarkView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkMainView: View {
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var noficationsManager: NotificationManager
    @EnvironmentObject var necessaryMenuViewModel: NecessaryMenuViewModel
    
    var body: some View {
        List {
            LastPageView()
                .id(0)
            BookmarkView()
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
        .viewTabToolbar(searchText: $routerManager.searchText,
                        title: routerManager.getNavigationTitle(),
                        navigationBarTrailing: routerManager.navigationBarTrailing())
        .onDisappear {
            routerManager.searchText = ""
            noficationsManager.checkNotificationPermission()
        }
        .sheet(isPresented: $necessaryMenuViewModel.showModel) {
            necessaryMenuViewModel.sheetDestination()
        }
    }
}

struct BookmarkMainView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkMainView()
            .environmentAllObject()
    }
}
