//
//  JuzRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct JuzRowView: View {
    let item: JuzModel
    @EnvironmentObject var language: LanguageViewModel
    
    var body: some View {
        let text = LocalizedStringKey("juz").stringValue(locale: language.language)
        HStack {
            HStack {
                Image(systemName: "app")
                    .font(.system(size: 34.0))
                    .overlay {
                        Text("\(item.index)")
                            .font(.system(size: 21.0))
                    }
                Text(text)
                    .font(.title2)
                Spacer()
            }.overlay {
                NavigationLink(value: Route.menu(item: item.page)) {
                    Text(">>>")
                }
                .opacity(0)
            }
            Menu {
                NavigationLink(value: Route.menu(item: item.page)) {
                    Label("\(item.index) \(text)", systemImage: "timelapse")
                }
                ForEach(item.surahs, id: \.index) { surahs in
                    NavigationLink(value: Route.menu(item: surahs.pageNumber.intValue)) {
                        Label(LocalizedStringKey(surahs.title.localizedForm), systemImage: surahs.type == "Makkiyah" ? "moon.fill" : "sun.max.fill")
                    }
                }
            } label: {
                Image(systemName: "list.dash")
                    .frame(width: 30, height: 30)
            }
        }
    }
}

struct JuzRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
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
            .environment(\.locale, Locale.init(identifier: "ru"))
            .environmentObject(LanguageViewModel())
        }
    }
}
