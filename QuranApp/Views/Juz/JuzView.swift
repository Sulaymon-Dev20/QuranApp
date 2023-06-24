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
    
    var body: some View {
        JuzListView(list: routerManager.sort ? filterData().reversed() : filterData())
            .viewTabToolbar(searchText: $routerManager.searchText,
                            title: routerManager.getNavigationTitle(),
                            navigationBarTrailing: routerManager.navigationBarTrailing())
            .onDisappear {
                routerManager.searchText = ""
            }
    }
    
    func filterData() -> [JuzModel] {
        if routerManager.searchText.count > 0 {
            return datas.items.filter { juz in
                juz.surahs.contains { surah in
                    return LocalizedStringKey(surah.title.localizedForm).stringValue().lowercased().contains(routerManager.searchText.lowercased())
                }
            }
        } else {
            return datas.items
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
