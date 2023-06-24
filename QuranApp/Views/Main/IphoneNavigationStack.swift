//
//  IphoneNavigationStack.swift
//  QuranApp
//
//  Created by Sulaymon on 23/06/23.
//

import SwiftUI

struct IphoneNavigationStack: View {
    @EnvironmentObject var routerManager: RouterManager

    var body: some View {
        NavigationStack(path: self.$routerManager.path) {
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
                    .tabItem {
                        Label("bookmarks", systemImage: "bookmark.circle")
                    }
                    .tag(2)
            }
            .searchable(text: $routerManager.searchText, placement: .toolbar, prompt: Text("search_surah"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(routerManager.getNavigationTitle(view: routerManager.tabValue))
            .toolbar(routerManager.tabBarHideStatus ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LanguageButtonView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    routerManager.navigationBarTrailing(view: routerManager.tabValue)
                }
            }
            .navigationDestination(for: Route.self) {
                routerManager.navigationDestination($0)
            }
        }
    }
}

struct IphoneNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        IphoneNavigationStack()
    }
}
