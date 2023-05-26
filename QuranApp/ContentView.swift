//
//  ContentView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var launchScreenViewModel: LaunchScreenViewModel

    var body: some View {
        TabMainView()
            .onAppear {
                DispatchQueue
                    .main
                    .asyncAfter(deadline: .now() + 5) {
                        launchScreenViewModel.dismiss()
                    }
            }
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
            .environmentObject(NoficationsManager())
            .environmentObject(PrayerTimeManager())
            .environmentObject(LocationManager())
            .environmentObject(ReviewsRequestManager())
    }
}
