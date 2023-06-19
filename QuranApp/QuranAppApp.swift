//
//  QuranAppApp.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI
import CoreSpotlight

@main
struct QuranAppApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var launchScreenViewModel: LaunchScreenViewModel = LaunchScreenViewModel()
    @StateObject var surahViewModel: SurahViewModel = SurahViewModel()
    @StateObject var bookmarksViewModel: BookMarkViewModel = BookMarkViewModel()
    @StateObject var notificatSurahViewModel: NotificatSurahViewModel = NotificatSurahViewModel()
    @StateObject var juzViewModel: JuzViewModel = JuzViewModel()
    @StateObject var noficationsManager: NoficationsManager = NoficationsManager()
    @StateObject var language: LanguageViewModel = LanguageViewModel()
    @StateObject var routerManager: RouterManager = RouterManager()
    @StateObject var prayerTimeManager: PrayerTimeManager = PrayerTimeManager()
    @StateObject var locationManager: LocationManager = LocationManager()
    @StateObject var reviewsManager: ReviewsRequestManager = ReviewsRequestManager()
    @StateObject var badgeAppManager: BadgeAppManager = BadgeAppManager()
    @StateObject var colorSchemeManager: ColorSchemeManager = ColorSchemeManager()
    @StateObject var necessaryMenuViewModel: NecessaryMenuViewModel = NecessaryMenuViewModel()

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                if launchScreenViewModel.state != .completed {
                    LaunchScreenView()
                }
            }
            .forceRotation(orientation: .portrait)
            .onOpenURL {
                routerManager.pushDeepLink(to: $0, list: surahViewModel.items)
            }
            .onAppear {
                appDelegate.app = self
            }
//            .environment(\.colorScheme, colorSchemeManager.getStatus() ?? colorScheme)
            .preferredColorScheme(colorSchemeManager.getStatus())
            .onContinueUserActivity(CSSearchableItemActionType, perform: loadItem)
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
            .environmentObject(badgeAppManager)
            .environmentObject(colorSchemeManager)
            .environmentObject(necessaryMenuViewModel)
            .environment(\.locale, Locale.init(identifier: language.language))
        }
    }
    
    func loadItem(_ userActivity: NSUserActivity) {
        print("nima gapla")
        if let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
            //            viewModel.selectItem(with: uniqueIdentifier)
            print(uniqueIdentifier)
        }
    }
}

