//
//  SurahView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct SurahView: View {
    @ObservedObject var datas = SurahViewModel()
    
    @State private var searchBarStatus = false
    @State private var searchFilter: String = ""
    @Binding var selectedTab: Int
    @Binding var hiddenBar: Bool

    var body: some View {
        NavigationView{
            SurahListView(list: filterData(),hiddenBar: $hiddenBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(hiddenBar || UIDevice.current.model == "iPad" ? .hidden : .visible, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        if searchBarStatus {
                            TextField("search_surah", text: $searchFilter)
                        } else{
                            if UIDevice.current.model == "iPad" {
                                Menu {
                                    Button {
                                        selectedTab = 1
                                    } label: {
                                        Text("juz")
                                    }
                                    Button {
                                        selectedTab = 2
                                    } label: {
                                        Text("bookmarks")
                                    }
                                } label: {
                                    Text("surahs")
                                }
                            } else {
                                Text("surahs")
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        LanguageButtonView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if searchBarStatus {
                                searchFilter = ""
                            }
                            searchBarStatus = !searchBarStatus
                        } label: {
                            Image(systemName: searchBarStatus ? "trash.slash.fill" : "magnifyingglass")
                        }
                    }
                }
        }
    }
    
    func filterData() -> [SurahModel] {
        if searchFilter.count > 0 {
            return datas.items.filter { item in
                item.toString().lowercased().contains(searchFilter.lowercased())
            }
        } else {
            return datas.items
        }
    }
}

struct SurahView_Previews: PreviewProvider {
    static var previews: some View {
        SurahView(selectedTab: .constant(0), hiddenBar: .constant(false))
            .environmentObject(BookMarkViewModel())
            .environmentObject(LanguageViewModel())
            .environment(\.locale, Locale.init(identifier: "uz"))
    }
}
