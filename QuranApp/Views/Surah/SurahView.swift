//
//  SurahView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct SurahView: View {
    @ObservedObject var datas = SurahViewModel()
    
    @State private var searchText: String = ""

    @State var sort: Bool = false
    @State var degree: Double = 0

    @Binding var selectedTab: Int
    @Binding var hiddenBar: Bool
    
    var body: some View {
        NavigationStack {
            SurahListView(list: sort ? filterData().reversed() : filterData(), hiddenBar: $hiddenBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(hiddenBar ? .hidden : .visible, for: .tabBar)
                .navigationTitle("surahs")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        LanguageButtonView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                self.sort = !sort
                                degree += 180
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .rotationEffect(.degrees(degree))
                                .animation(.linear(duration: 0.3), value: sort)
                            
                        }
                    }
                }
                .searchable(text: $searchText, placement: .toolbar, prompt: Text("search_surah"))
        }
    }
    
    func filterData() -> [SurahModel] {
        if searchText.count > 0 {
            return datas.items.filter { item in
                item.toString().lowercased().contains(searchText.lowercased())
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
//            .environment(\.locale, Locale.init(identifier: "uz"))
    }
}
