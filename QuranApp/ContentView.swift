//
//  ContentView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var launchScreenViewModel: LaunchScreenViewModel = LaunchScreenViewModel()
    @StateObject var surahViewModel: SurahViewModel = SurahViewModel()
    @StateObject var bookmarksViewModel: BookMarkViewModel = BookMarkViewModel()
    @StateObject var notificatSurahViewModel: NotificatSurahViewModel = NotificatSurahViewModel()
    @StateObject var language: LanguageViewModel = LanguageViewModel()
    @StateObject var navigationRouter: NavigationRouter = NavigationRouter()
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            TabMainView(selectedTab: $selectedTab)
            if launchScreenViewModel.state != .completed {
                LaunchScreenView()
            }
        }
        .onOpenURL{ url in
            Task{
                self.selectedTab = getPage(url: url)
                let queryParams = url.queryParameters
                if let indexQueryVal = queryParams?["index"] as? String {
                    if let item = surahViewModel.items.first(where: {$0.index == indexQueryVal}) {
                        navigationRouter.push(to: Route.surah(item: item))
                    }
                }
            }
        }
        .environmentObject(surahViewModel)
        .environmentObject(launchScreenViewModel)
        .environmentObject(language)
        .environmentObject(bookmarksViewModel)
        .environmentObject(notificatSurahViewModel)
        .environmentObject(navigationRouter)
        .environment(\.locale, Locale.init(identifier: language.language))
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value?.replacingOccurrences(of: "+", with: " ")
        }
    }
}
