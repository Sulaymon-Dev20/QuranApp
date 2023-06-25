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
    @EnvironmentObject var routerManager: RouterManager
    
    var body: some View {
        let text = LocalizedStringKey("juz").stringValue(locale: language.language)
        HStack {
            Button {
                routerManager.setCurrentPage(to: item.index)
            } label: {
                HStack {
                    Image(systemName: "app")
                        .font(.system(size: 34.0))
                        .overlay {
                            Text("\(item.index)")
                                .font(.system(size: 21.0))
                        }
                    VStack {
                        Text(text)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(getSurahsToString(item.surahs))
                            .font(.caption2)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                }
            }
            .foregroundColor(Color.primary)
            .hiddinNativiation(value: Route.menu(item: item))
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
                HStack {
                    Spacer()
                    Image(systemName: "list.dash")
                        .font(.title2)
                }
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .frame(width: 80)
                .contentShape(Rectangle())
            }
            .hideIfPad()
        }
    }
    
    func getSurahsToString(_ list:[Surah]) -> String {
        var res = ""
        list.forEach { item in
            res += LocalizedStringKey(item.title.localizedForm).stringValue() + ", "
        }
        res = res.trimmingCharacters(in: .whitespacesAndNewlines)
        res.removeLast()
        return res
    }
}

struct JuzRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                JuzRowView(item: JuzModel(index: 1, page:1, surahs:
                                            [
                                                Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "2",type: "Makkiyah"),
                                                Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "2",type: "Makkiyah"),
                                                Surah(titleAr: "", title: "Al-Fatiha", index: 2, verse: VerseNew(start: 12, end: 12), pageNumber: "2",type: "Makkiyah")
                                            ]))
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
            .environmentObject(RouterManager())
        }
    }
}
