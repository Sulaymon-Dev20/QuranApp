//
//  BookmarkRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct BookmarkRowView: View {
    let item: BookmarkModel
    
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
                    Text("\("page".lv) \(item.pageNumber), \("juz".lv) \(item.juz.intValue)")
                    Spacer()
                }
            }
            Text("\(item.pageNumber)")
                .font(.system(size: 34.0))
        }
        .overlay {
            NavigationLink(value: Route.menu(item: item)) {
                Text(">>>")
            }
            .opacity(0)
        }
    }
}

struct BookmarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BookmarkRowView(item: BookmarkModel(title: "Al-Imran", juz: "3", pageNumber: 50))
            BookmarkRowView(item: BookmarkModel(title: "Al-Imran", juz: "3", pageNumber: 50))
            BookmarkRowView(item: BookmarkModel(title: "Al-Imran", juz: "3", pageNumber: 50))
        }
        .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
