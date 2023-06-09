//
//  BookmarkRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkRowView: View {
    let item: BookmarkModel
    
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var languageViewModel: LanguageViewModel

    var body: some View {
        HStack {
            Image(systemName: "book.closed")
                .font(.system(size: 34.0))
            VStack{
                HStack{
                    Text(LocalizedStringKey(item.title.localizedForm))
                        .bold()
                    Spacer()
                }
                HStack{
                    Text(LocalizedStringKey("page").stringValue()+" \(item.pageNumber), \(LocalizedStringKey("juz").stringValue()) \(item.juz.intValue)".convertedDigitsToLocale(languageViewModel.language))
                    Spacer()
                }
            }
            Text("\(item.pageNumber)")
                .font(.system(size: 34.0))
        }
        .navigationButton(action: {
            routerManager.setCurrentPage(to: item.pageNumber)
        })
        .hiddinNativiation(value: Route.menu(item: item))
    }
}

struct BookmarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BookmarkRowView(item: BookmarkModel(title: "Al-Imran", juz: "3", pageNumber: 50))
            BookmarkRowView(item: BookmarkModel(title: "Al-Imran", juz: "3", pageNumber: 50))
            BookmarkRowView(item: BookmarkModel(title: "Al-Imran", juz: "3", pageNumber: 50))
        }
    }
}
