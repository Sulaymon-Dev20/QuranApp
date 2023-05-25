//
//  JuzRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct JuzRowView: View {
    @EnvironmentObject var routerManager: RouterManager

    let item: JuzModel

    var body: some View {
        NavigationLink(destination: PDFViewUI(pageNumber: item.page)
            .onAppear {
                routerManager.tabBarHide(status: true)
            }
        ) {
            HStack{
                Image(systemName: "app")
                    .font(.system(size: 34.0))
                    .overlay {
                        Text("\(item.index)")
                            .font(.system(size: 21.0))
                    }
                Text("juz")
                    .font(.title2)
                Spacer()
            }
        }
        .contextMenu{
            ForEach(item.surahs, id: \.index) {surahs in
                NavigationLink(destination: PDFViewUI(pageNumber: surahs.pageNumber.intValue)
                    .onAppear {
                        routerManager.tabBarHide(status: true)
                    }
                ) {
                    Label(surahs.title.localizedForm, systemImage: surahs.type == "Makkiyah" ? "moon.fill" : "sun.max.fill")
                }
            }
        }
    }
}

struct JuzRowView_Previews: PreviewProvider {
    static var previews: some View {
        List{
            JuzRowView(item: JuzModel(index: 1, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "2",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 1, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "2",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 2, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "1",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 5, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "9",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 17, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "1",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 0, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "4",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 04, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "6",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 12, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "12",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 12, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "12",type: "Makkiyah")]))
            JuzRowView(item: JuzModel(index: 12, page:1, surahs: [Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "12",type: "Makkiyah")]))
        }
        .environmentObject(LanguageViewModel())
        .environment(\.locale, Locale.init(identifier: "ru"))
    }
}
