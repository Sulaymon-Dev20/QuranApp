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
    @StateObject var language: LanguageViewModel = LanguageViewModel()
    @StateObject var routerManager: RouterManager = RouterManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView()
                if launchScreenViewModel.state != .completed {
                    LaunchScreenView()
                }
            }
            .onOpenURL{ url in
                Task{
//                    self.selectedTab = getPage(url: url)
                    routerManager.pushTab(to: getPage(url: url))
                    let queryParams = url.queryParameters
                    if let indexQueryVal = queryParams?["index"] as? String {
                        if let item = surahViewModel.items.first(where: {$0.index == indexQueryVal}) {
                            routerManager.push(to: Route.surah(item: item))
                        }
                    }
                }
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
            .environment(\.locale, Locale.init(identifier: language.language))
        }
    }
    
    func getPage(url: URL) -> Int {
        let host = url.host()
        switch host {
        case "surahs":
            return 0
        case "juz":
            return 1
        case "bookmark":
            return 2
        default:
            return 0
        }
    }
}

