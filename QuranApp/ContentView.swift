//
//  ContentView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bookmarksViewModel: BookMarkViewModel = BookMarkViewModel()
    @StateObject var language: LanguageViewModel = LanguageViewModel()

    var body: some View {
        TabMainView()
            .environmentObject(language)
            .environmentObject(bookmarksViewModel)
            .environment(\.locale, Locale.init(identifier: language.language))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
