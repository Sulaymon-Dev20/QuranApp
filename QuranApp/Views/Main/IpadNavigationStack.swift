//
//  IpadNavigationStack.swift
//  QuranApp
//
//  Created by Sulaymon on 23/06/23.
//

import SwiftUI

struct IpadNavigationStack: View {
    @EnvironmentObject var routerManager: RouterManager
    
    var body: some View {
        NavigationSplitView {
            List(tabViewItemsList, selection: $routerManager.tabValue) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.icon)
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LanguageButtonView()
                }
            }
        } content: {
            routerManager.tabValue?.view
                .navigationDestination(for: Route.self) {
                    routerManager.navigationDestination($0)
                }
        } detail: {
            routerManager.view
        }
    }
}

struct IpadNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        IpadNavigationStack()
            .environmentAllObject()
    }
}
