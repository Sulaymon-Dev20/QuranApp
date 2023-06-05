//
//  NavigationRouter.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import Foundation
import SwiftUI

class RouterManager: ObservableObject {
    
    @Published var path = [Route]()
    @Published var tabValue: Int = 0
    @Published var tabBarHideStatus: Bool = false
    
    func gotoHomePage() {
        path.removeLast(path.count)
    }
    
    func push(to item: Route) {
        if !path.contains(item) {
            path.append(item)
        }
    }
//    there will be write greate solution ASAP
    func navigationDestination(_ route:any Hashable) -> some View {
        switch route {
        case Route.menu(let item):
            switch item{
            case let pageNumber as Int:
                return PDFViewUI(pageNumber: pageNumber)
            case let surahModel as SurahModel:
                return PDFViewUI(pageNumber: surahModel.pages.intValue)
            case let bookmarkModel as BookmarkModel:
                return PDFViewUI(pageNumber: bookmarkModel.pageNumber)
            default:
                return PDFViewUI(pageNumber: (item as! SurahModel).pages.intValue)
            }
        default:
            return PDFViewUI(pageNumber: 1)
        }
    }
    
    func tapOnSecondPage() {
        path.removeLast()
    }
    
    func pushTab(to item: Int) {
        tabValue = item
    }
    
    func tabBarHide(status: Bool) {
        tabBarHideStatus = status
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

extension RouterManager {
    func pushDeepLink(to url: URL, list items: [SurahModel]) {
        pushTab(to: getPage(url: url))
        let queryParams = url.queryParameters
        if queryParams?["notification"] as? Bool ?? false {
            UIApplication.shared.applicationIconBadgeNumber -= 1
        }
        if let indexQueryVal = queryParams?["index"] as? String {
            if let item = items.first(where: {$0.index == indexQueryVal}) {
                push(to: Route.menu(item: item))
            }
        }
    }
}
