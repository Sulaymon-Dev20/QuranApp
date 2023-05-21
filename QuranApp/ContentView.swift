//
//  ContentView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var launchScreenViewModel:LaunchScreenViewModel = LaunchScreenViewModel()
    @StateObject var bookmarksViewModel: BookMarkViewModel = BookMarkViewModel()
    @StateObject var language: LanguageViewModel = LanguageViewModel()

    var body: some View {
        ZStack {
            TabMainView()
            if launchScreenViewModel.state != .completed {
                LaunchScreenView()
            }
        }
        .environmentObject(launchScreenViewModel)
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
