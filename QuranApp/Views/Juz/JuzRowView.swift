//
//  JuzRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct JuzRowView: View {
    let item:JuzModel
    @Binding var hiddenBar: Bool
    var body: some View {
        NavigationLink(destination: PDFViewUI(pageNumber: item.page, hiddenBar: $hiddenBar)
            .onAppear {
                self.hiddenBar = true
            }
        ) {
            HStack{
                Image(systemName: "app")
                    .font(.system(size: 34.0))
                    .overlay {
                        Text("\(item.index)")
                            .font(.system(size: 11.0))
                    }
                Text("juz")
                    .font(.title2)
                Spacer()
            }
        }
        .contextMenu{
            ForEach(item.surahs, id: \.index) {surahs in
                NavigationLink(destination: PDFViewUI(pageNumber: (surahs.pageNumber as NSString).integerValue, hiddenBar: $hiddenBar)
                    .onAppear {
                        self.hiddenBar = true
                    }
                ) {
                    Label(LocalizedStringKey(surahs.title.lowercased().replacingOccurrences(of: "-", with: "_")), systemImage: surahs.type == "Makkiyah" ? "moon.fill" : "sun.max.fill")
                }
            }
        }
    }
}

struct JuzRowView_Previews: PreviewProvider {
    static var previews: some View {
        List{
            JuzRowView(item: JuzModel(index: 12, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "12",type: "Makkiyah")]), hiddenBar: .constant(false))
        }
        .environmentObject(LanguageViewModel())
        .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
