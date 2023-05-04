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
                    NavigationLink(destination:
                                    PDFViewUI(pageNumber: (item.pages as NSString).integerValue, hiddenBar: $hiddenBar)
                        .onAppear {
                            self.hiddenBar = true
                        }
                    ) {
                        SurahRowView(number: (item.index as NSString).integerValue, name: item.title, type: item.type, verses: item.count, pageNumber: item.pages)
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
        SurahListView(list: [], hiddenBar: .constant(false))
    }
}
