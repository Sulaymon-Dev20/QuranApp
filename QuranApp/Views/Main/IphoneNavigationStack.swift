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
        let tabview: Binding<Int> = .init(get: { () -> Int in
            return routerManager.tabValue!.id
        }, set: { (value) in
            routerManager.pushTab(to: value)
        })
        NavigationStack(path: self.$routerManager.path) {
            TabView(selection: tabview) {
                ForEach(tabViewItemsList) { item in
                    item.view
                        .tabItem {
                            Label(item.title, systemImage: item.icon)
                        }
                        .tag(item.id)
                }
            }
            .searchable(text: $routerManager.searchText, placement: .toolbar, prompt: Text("search_surah"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(routerManager.getNavigationTitle())
            .toolbar(routerManager.tabBarHideStatus ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LanguageButtonView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    routerManager.navigationBarTrailing()
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
            .environmentAllObject()
    }
}
