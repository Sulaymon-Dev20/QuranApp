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
    @State private var selectedPerson: Int? = 0
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    SurahView()
                } label: {
                    Label("surahs", systemImage: "book.circle")
                }
                NavigationLink {
                    JuzView()
                } label: {
                    Label("juz", systemImage: "mountain.2.circle.fill")
                }
                NavigationLink {
                    BookmarkView()
                } label: {
                    Label("bookmarks", systemImage: "bookmark.circle")
                }
            }
            .onAppear {
                print("asdf")
            }
            .onDisappear{
                print("dis")
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LanguageButtonView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    routerManager.navigationBarTrailing(view: routerManager.tabValue)
                }
            }
        } content: {
            SurahView()
                .searchable(text: $routerManager.searchText, placement: .toolbar, prompt: Text("search_surah"))
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(routerManager.getNavigationTitle(view: routerManager.tabValue))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        routerManager.navigationBarTrailing(view: routerManager.tabValue)
                    }
                }
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
