//
//  BookmarkRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkRowView: View {
    @EnvironmentObject var language: LanguageViewModel

    let title, juz: String
    let pageNumber: Int
    
    var body: some View {
        HStack {
            Image(systemName: "book.closed")
                .font(.system(size: 34.0))
            VStack{
                HStack{
                    Text(LocalizedStringKey(title.localizedForm))
                        .bold()
                    Spacer()
                }
                HStack{
                    Text("\("page".locVal(language.language,capitalized: true)) \(pageNumber.toString), \("juz".locVal(language.language,capitalized: true)) \(juz.intValue)")
                    Spacer()
                }
            }
            Text("\(pageNumber)")
                .font(.system(size: 34.0))
        }
    }
}

struct BookmarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BookmarkRowView(title: "Al-Imran", juz: "3", pageNumber: 50)
            BookmarkRowView(title: "Al-Imran", juz: "3", pageNumber: 50)
            BookmarkRowView(title: "Al-Imran", juz: "3", pageNumber: 50)
        }
        .environmentObject(LanguageViewModel())
        .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
