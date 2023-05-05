//
//  SurahListView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct SurahListView: View {
    let list: [SurahModel]
    @Binding var hiddenBar: Bool
    
    var body: some View {
        if !list.isEmpty {
            List {
                ForEach(list, id: \.title){ item in
                    SurahRowView(number: (item.index as NSString).integerValue, name: item.title, type: item.type, verses: item.count, pageNumber: item.pages)
                        .overlay {
                            NavigationLink(destination:
                                            PDFViewUI(pageNumber: (item.pages as NSString).integerValue, hiddenBar: $hiddenBar)
                                .onAppear {
                                    self.hiddenBar = true
                                }
                            ) {
                                Text(">>>")
                            }
                            .opacity(0)
                        }
                }
            }
        } else {
            ListEmptyView()
        }
    }
}

struct SurahListView_Previews: PreviewProvider {
    static var previews: some View {
        SurahListView(list: [SurahModel(place: Place.mecca, type: TypeEnum.makkiyah, count: 22, title: "al_fatiha", titleAr: "String", index: "12", pages: "12", juz: [])], hiddenBar: .constant(false))
    }
}
