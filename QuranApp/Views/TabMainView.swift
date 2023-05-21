//
//  TabViewMain.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct TabMainView: View {
    
    @EnvironmentObject var launchScreenViewModel: LaunchScreenViewModel
    
    @State var selectedTab: Int = 0
    @State var hiddenBar: Bool = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                SurahView(selectedTab: $selectedTab, hiddenBar: $hiddenBar)
                    .tabItem {
                        Label("surahs", systemImage: "book.circle")
                    }
                    .tag(0)
                JuzView(selectedTab: $selectedTab, hiddenBar: $hiddenBar)
                    .tabItem {
                        Label("juz", systemImage: "mountain.2.circle.fill")
                    }
                    .tag(1)
                BookmarkView(selectedTab: $selectedTab, hiddenBar: $hiddenBar)
                    .tabItem {
                        Label("bookmarks", systemImage: "bookmark.circle")
                    }
                    .tag(2)
            }
            .accentColor(Color.primary)
            .toolbarRole(ToolbarRole.automatic)
        }
        .onAppear{
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 5) {
                    launchScreenViewModel.dismiss()
                }
        }
    }
}

struct TabMainView_Previews: PreviewProvider {
    static var previews: some View {
        TabMainView()
            .environmentObject(LaunchScreenViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(LanguageViewModel())
    }
}
