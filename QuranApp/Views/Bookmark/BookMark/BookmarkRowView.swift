//
//  BookmarkRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkRowView: View {
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
                    Text("page \(pageNumber.toString)")
                    Text("Juz \(juz.intValue)")
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
        .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
