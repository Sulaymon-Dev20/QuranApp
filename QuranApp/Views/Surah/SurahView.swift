//
//  SurahView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct SurahView: View {
    @EnvironmentObject var datas: SurahViewModel
    @EnvironmentObject var routeManager: RouterManager
    
    @State var searchText: String = ""
    @State var sort: Bool = false
    
    var body: some View {
        NavigationStack(path: self.$routeManager.path) {
            SurahListView(list: sort ? filterData().reversed() : filterData())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("surahs")
                .toolbar(routeManager.tabBarHideStatus ? .hidden : .visible, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        LanguageButtonView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SortButtonView(sort: $sort)
                    }
                }
                .searchable(text: $searchText, placement: .toolbar, prompt: Text("search_surah"))
                .navigationDestination(for: Route.self) {
                    routeManager.navigationDestination($0)
                }
        }
        .onDisappear {
            searchText = ""
        }
    }
    
    func filterData() -> [SurahModel] {
        if searchText.count > 0 {
            return datas.items.filter {
                return LocalizedStringKey($0.title.localizedForm).stringValue().lowercased().contains(searchText.lowercased())
            }
        } else {
            return datas.items
        }
    }
    
    struct SurahView_Previews: PreviewProvider {
        static var previews: some View {
            SurahView()
                .environmentObject(SurahViewModel())
                .environmentObject(BookMarkViewModel())
                .environmentObject(NotificatSurahViewModel())
                .environmentObject(LanguageViewModel())
                .environmentObject(RouterManager())
                .environmentObject(ReviewsRequestManager())
                .environmentObject(NoficationsManager())
        }
    }
}

