//
//  QuranAppApp.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

@main
struct QuranAppApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
    
    @StateObject var launchScreenViewModel: LaunchScreenViewModel = LaunchScreenViewModel()
    @StateObject var surahViewModel: SurahViewModel = SurahViewModel()
    @StateObject var bookmarksViewModel: BookMarkViewModel = BookMarkViewModel()
    @StateObject var notificatSurahViewModel: NotificatSurahViewModel = NotificatSurahViewModel()
    @StateObject var juzViewModel: JuzViewModel = JuzViewModel()
    @StateObject var noficationsManager = NoficationsManager()
    @StateObject var language: LanguageViewModel = LanguageViewModel()
    @StateObject var routerManager: RouterManager = RouterManager()
    @StateObject var prayerTimeManager: PrayerTimeManager = PrayerTimeManager()
    @StateObject var locationManager: LocationManager = LocationManager()
    @StateObject var reviewsManager: ReviewsRequestManager = ReviewsRequestManager()

    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView()
                if launchScreenViewModel.state != .completed {
                    LaunchScreenView()
                }
            }
            .onOpenURL {
                routerManager.pushDeepLink(to: $0, list: surahViewModel.items)
            }
            .onAppear {
                appDelegate.app = self
            }
            .environmentObject(surahViewModel)
            .environmentObject(launchScreenViewModel)
            .environmentObject(language)
            .environmentObject(bookmarksViewModel)
            .environmentObject(notificatSurahViewModel)
            .environmentObject(routerManager)
            .environmentObject(juzViewModel)
            .environmentObject(locationManager)
            .environmentObject(noficationsManager)
            .environmentObject(prayerTimeManager)
            .environmentObject(reviewsManager)
            .environment(\.locale, Locale.init(identifier: language.language))
        }
    }
}

