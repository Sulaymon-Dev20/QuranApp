//
//  IpadNavigationStack.swift
//  QuranApp
//
//  Created by Sulaymon on 23/06/23.
//

import SwiftUI

struct IpadNavigationStack: View {
    @EnvironmentObject var routerManager: RouterManager
    @State var list:[String] = ["surahs", "juz", "bookmarks"]
    
    var body: some View {
        NavigationSplitView {
            List(tabViewItemsList, selection: $routerManager.tabValue) { item in
                NavigationLink {
                    item.view
                } label: {
                    Label(item.title, systemImage: item.icon)
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LanguageButtonView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    routerManager.navigationBarTrailing()
                }
            }
        } content: {
            routerManager.tabValue?.view
                .viewTabToolbar(searchText: $routerManager.searchText,
                                title: routerManager.getNavigationTitle(),
                                navigationBarTrailing: routerManager.navigationBarTrailing())
        } detail: {
            NavigationStack(path: self.$routerManager.path) {
                routerManager.view
            }
            .navigationDestination(for: Route.self) {
                routerManager.navigationDestination($0)
            }
        }
    }
}

struct IpadNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        IpadNavigationStack()
            .environmentObject(SurahViewModel())
            .environmentObject(LaunchScreenViewModel())
            .environmentObject(LanguageViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(RouterManager())
            .environmentObject(JuzViewModel())
            .environmentObject(LocationManager())
            .environmentObject(NoficationsManager())
            .environmentObject(PrayerTimeManager())
            .environmentObject(ReviewsRequestManager())
            .environmentObject(BadgeAppManager())
            .environmentObject(ColorSchemeManager())
            .environmentObject(NecessaryMenuViewModel())
    }
}
