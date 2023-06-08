//
//  JuzView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct JuzView: View {
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var datas: JuzViewModel
    
    @State var sort: Bool = false
    
    var body: some View {
        NavigationStack(path: self.$routerManager.path) {
            ZStack {
                List {
                    ForEach(sort ? datas.items.reversed() : datas.items, id: \.index) { item in
                        JuzRowView(item: item)
                    }
                }
                .animation(.linear(duration: 3.0), value: sort)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("juz")
            .toolbar(routerManager.tabBarHideStatus ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LanguageButtonView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    SortButtonView(sort: $sort)
                }
            }
            .navigationDestination(for: Route.self) {
                routerManager.navigationDestination($0)
            }
        }
    }
}

struct JuzView_Previews: PreviewProvider {
    static var previews: some View {
        JuzView()
            .environmentObject(JuzViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(LanguageViewModel())
            .environmentObject(RouterManager())
        //            .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
