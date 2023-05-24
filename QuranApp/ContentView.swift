//
//  ContentView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabMainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SurahViewModel())
            .environmentObject(LaunchScreenViewModel())
            .environmentObject(LanguageViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(RouterManager())
            .environmentObject(JuzViewModel())
    }
}
